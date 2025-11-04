{pkgs, ...}: {
  programs.neovim.plugins = [pkgs.vimPlugins.substitute-nvim];
  xdg.configFile = {
    "nvim/lua/plugins/editing/substitute-nvim.lua".source =
      ../../src/lua/plugins/editing/substitute-nvim.lua;
  };
}
