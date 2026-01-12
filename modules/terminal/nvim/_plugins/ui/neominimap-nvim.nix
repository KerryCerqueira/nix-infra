{
  pkgs,
  lib,
  ...
}: let
  neominimap-nvim = let
    tag = "v3.15.2";
    version = lib.removePrefix "v" tag;
    hash = "sha256-HiP0xH4NyrX4lvmTDFbwYv0Hfl176Au9Q/ellJSPCuw=";
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "neominimap.nvim";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "Isrothy";
        repo = "neominimap.nvim";
        rev = tag;
        inherit hash;
      };
    };
in {
  programs.neovim.plugins = [neominimap-nvim];
  xdg.configFile = {
    "nvim/lua/plugins/ui/neominimap-nvim.lua".source =
      ../../src/lua/plugins/ui/neominimap-nvim.lua;
  };
}
