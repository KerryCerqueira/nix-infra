{...}: {
  flake.wrappers.neovim = {
    pkgs,
    config,
    lib,
    ...
  }: let
    oil-git-nvim = let
      commitDate = "2025-09-02T21:44:24-04:00";
      version = "unstable-" + commitDate;
      rev = "d1f27a5982df35b70fb842aa6bbfac10735c7265";
      hash = "sha256-QQj3ck+5GpA/htG0tZzniS5bbfRscvcfXjMUjY8F9A4=";
    in
      pkgs.vimUtils.buildVimPlugin {
        pname = "oil-git.nvim";
        inherit version;
        src = pkgs.fetchFromGitHub {
          owner = "benomahony";
          repo = "oil-git.nvim";
          inherit rev hash;
        };
      };
    oil-lsp-diagnostics-nvim = let
      commitDate = "2025-01-22T08:03:14-06:00";
      version = "unstable-" + commitDate;
      rev = "e04e3c387262b958fee75382f8ff66eae9d037f4";
      hash = "sha256-E8jukH3I8XDdgrG4XHCo9AuFbY0sLX24pjk054xmB9E=";
    in
      pkgs.vimUtils.buildVimPlugin {
        pname = "oil-lsp-diagnostics.nvim";
        inherit version;
        src = pkgs.fetchFromGitHub {
          owner = "JezerM";
          repo = "oil-lsp-diagnostics.nvim";
          inherit rev hash;
        };
        doCheck = false;
      };
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
        neo-tree-nvim = {
          name = "neo-tree.nvim";
          pkg = pkgs.vimPlugins.neo-tree-nvim;
        };
        plenary-nvim = {
          name = "plenary.nvim";
          pkg = pkgs.vimPlugins.plenary-nvim;
        };
        nui-nvim = {
          name = "nui.nvim";
          pkg = pkgs.vimPlugins.nui-nvim;
        };
        mini-icons = {
          name = "mini.icons";
          pkg = pkgs.vimPlugins.mini-icons;
        };
        oil-nvim = {
          name = "oil.nvim";
          pkg = pkgs.vimPlugins.oil-nvim;
        };
        oil-git-nvim = {
          name = "oil-git.nvim";
          pkg = oil-git-nvim;
        };
        oil-lsp-diagnostics-nvim = {
          name = "oil-lsp-diagnostics.nvim";
          pkg = oil-lsp-diagnostics-nvim;
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
