{pkgs, ...}: {
  programs.neovim.plugins = [pkgs.vimPlugins.conform-nvim];
  xdg.configFile = {
    "nvim/lua/plugins/editing/conform-nvim.lua".source =
      ../../src/lua/plugins/editing/conform-nvim.lua;
  };
}
