{pkgs, ...}: {
  programs.neovim.plugins = [pkgs.vimPlugins.mini-bracketed];
  xdg.configFile = {
    "nvim/lua/plugins/editing/mini-bracketed.lua".source =
      ../../src/lua/plugins/editing/mini-bracketed.lua;
  };
}
