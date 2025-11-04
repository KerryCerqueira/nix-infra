{pkgs, ...}: let
  visual-whitespace-nvim = let
    commitDate = "2025-04-14";
    version = "unstable-" + commitDate;
    rev = "99898e2c26d06c9109820236228c7ce6df86e51c";
    hash = "sha256-ofiBFp3rZnGpkaBy4WG8YLcLb+EQFlRcQv7eF3adMZM=";
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
