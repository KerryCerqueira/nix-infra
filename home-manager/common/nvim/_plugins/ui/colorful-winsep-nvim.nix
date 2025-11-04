{pkgs, ...}: let
  colorful-winsep-nvim = let
    commitDate = "2025-09-05T15:11:21+08:00";
    version = "unstable-" + commitDate;
    rev = "1d5d1e33a4e1b8d692a63bf400e837e9b294d239";
    hash = "sha256-T+PfRGyo0QjpKmlJiN8C4+Hk4TWL/UO91NWHrXX62RQ=";
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "colorful-winsep.nvim";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "nvim-zh";
        repo = "colorful-winsep.nvim";
        inherit rev hash;
      };
    };
in {
  programs.neovim.plugins = [colorful-winsep-nvim];
  xdg.configFile = {
    "nvim/lua/plugins/ui/colorful-winsep-nvim.lua".source =
      ../../src/lua/plugins/ui/colorful-winsep-nvim.lua;
  };
}
