{
  pkgs,
  lib,
  ...
}: let
  beacon-nvim = let
    tag = "v2.0.0";
    version = lib.removePrefix "v" tag;
    hash = "sha256-w5uhTVYRgkVCbJ5wrNTKs8bwSpH+4REAr9gaZrbknH8=";
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "beacon.nvim";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "DanilaMihailov";
        repo = "beacon.nvim";
        rev = tag;
        inherit hash;
      };
    };
in {
  programs.neovim.plugins = [
    beacon-nvim
  ];
  xdg.configFile = {
    "nvim/lua/plugins/ui/beacon-nvim.lua".source =
      ../../src/lua/plugins/ui/beacon-nvim.lua;
  };
}
