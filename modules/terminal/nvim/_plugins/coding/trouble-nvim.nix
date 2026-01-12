{pkgs, ...}: {
  programs.neovim.plugins = [pkgs.vimPlugins.trouble-nvim];
  xdg.configFile = {
    "nvim/lua/plugins/coding/trouble-nvim.lua".source =
      ../../src/lua/plugins/coding/trouble-nvim.lua;
  };
}
