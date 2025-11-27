{pkgs, ...}: let
  colorful-winsep-nvim = let
    commitDate = "2025-09-30T07:38:50Z";
    version = "unstable-" + commitDate;
    rev = "e555611c8f39918e30d033a97ea1a5af457ce75e";
    hash = "sha256-BNQ/MklqSGcyOeozytq1B71jnj85Bb+QQX7rAj//tjg=";
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
