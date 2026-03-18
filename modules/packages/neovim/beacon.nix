{...}: {
  flake.wrappers.neovim = {
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
    lazy.specs = [
      {
        name = "beacon.nvim";
        pkg = beacon-nvim;
        luaSpec = ./src/lazyspecs/ui/beacon-nvim.lua;
      }
    ];
  };
}
