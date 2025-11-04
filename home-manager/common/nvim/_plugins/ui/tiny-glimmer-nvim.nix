{pkgs, ...}: let
  tiny-glimmer-nvim = let
    commitDate = "2025-03-07";
    version = "unstable-" + commitDate;
    rev = "70234ad3d193a187c81cb16007100b790c9801fc";
    hash = "sha256-X/uShlNIROhcqaOOsmu2mkMuvUcNgwp010HKF0KeTdk=";
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = "tiny-glimmer.nvim";
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "rachartier";
        repo = "tiny-glimmer.nvim";
        inherit rev hash;
      };
      nvimSkipModules = ["test"];
    };
in {
  xdg.configFile = {
    "nvim/lua/plugins/ui/tiny-glimmer-nvim.lua".source =
      ../../src/lua/plugins/ui/tiny-glimmer-nvim.lua;
  };
  programs.neovim.plugins = [
    tiny-glimmer-nvim
  ];
}
