{...}: {
  flake.wrappers.neovim = {
    pkgs,
    config,
    lib,
    ...
  }: let
    sshfs-nvim = let
      tag = "v1.0.1";
      version = lib.removePrefix "v" tag;
      hash = "sha256-9KWueK945w7p+Du4bmUtWZCnk143Z2VTaDtdRObVcgo=";
    in
      pkgs.vimUtils.buildVimPlugin {
        pname = "sshfs.nvim";
        inherit version;
        src = pkgs.fetchFromGitHub {
          owner = "uhs-robert";
          repo = "sshfs.nvim";
          rev = tag;
          inherit hash;
        };
      };
  in {
    lazy = {
      plugins = {
        fyler-nvim = {
          name = "fyler.nvim";
          pkg = pkgs.vimPlugins.fyler-nvim;
        };
        mini-icons = {
          name = "mini.icons";
          pkg = pkgs.vimPlugins.mini-icons;
        };
        sshfs-nvim = {
          name = "sshfs.nvim";
          pkg = sshfs-nvim;
        };
      };
      specs = [
        (config.lazy.configSrc + "/lua/lazyspecs/filetree.lua")
      ];
    };
    extraPackages = with pkgs; [
      delta
      fd
      ripgrep
    ];
  };
}
