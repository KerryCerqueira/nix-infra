{pkgs, ...}: let
  visual-whitespace-nvim = let
    commitDate = "2025-11-24T09:28:15-07:00";
    version = "unstable-" + commitDate;
    rev = "2c2de32bb97620bcf4b3b78879c185315ee971dc";
    hash = "sha256-G/jmNxRTg426hROvmw1d4R3bAP09si97ZsYs3fCGWzA=";
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "visual-whitespace.nvim";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "mcauley-penney";
        repo = "visual-whitespace.nvim";
        inherit rev hash;
      };
    };
in {
  xdg.configFile = {
    "nvim/lua/plugins/ui/visual-whitespace-nvim.lua".source =
      ../../src/lua/plugins/ui/visual-whitespace-nvim.lua;
  };
  programs.neovim.plugins = [
    visual-whitespace-nvim
  ];
}
