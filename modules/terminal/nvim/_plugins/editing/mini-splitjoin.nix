{pkgs, ...}: {
  programs.neovim.plugins = [pkgs.vimPlugins.mini-splitjoin];
  xdg.configFile = {
    "nvim/lua/plugins/editing/mini-splitjoin.lua".source =
      ../../src/lua/plugins/editing/mini-splitjoin.lua;
  };
}
