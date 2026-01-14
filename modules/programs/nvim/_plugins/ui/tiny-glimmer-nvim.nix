{pkgs, ...}: let
  tiny-glimmer-nvim = let
    commitDate = "2025-11-22T23:49:03+01:00";
    version = "unstable-" + commitDate;
    rev = "e83bab26665c2dd4153b8a24e172e674e7c6dee7";
    hash = "sha256-4dSD4mosR87cA3Z+hm44y/krRtIDarWSTwPAKC9pqAo=";
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
