{
  pkgs,
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
  programs.neovim = {
    plugins = [sshfs-nvim];
    extraPackages = [pkgs.sshfs];
  };
  xdg.configFile = {
    "nvim/lua/plugins/ui/sshfs-nvim.lua".source =
      ../../src/lua/plugins/ui/sshfs-nvim.lua;
  };
}
