{pkgs, ...}: {
  programs.neovim.plugins = [pkgs.vimPlugins.mini-trailspace];
  xdg.configFile = {
    "nvim/lua/plugins/editing/mini-trailspace.lua".source =
      ../../src/lua/plugins/editing/mini-trailspace.lua;
  };
}
