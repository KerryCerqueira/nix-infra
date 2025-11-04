{pkgs, ...}: {
  programs.neovim.plugins = [pkgs.vimPlugins.mini-basics];
  xdg.configFile = {
    "nvim/lua/plugins/ui/mini-basics.lua".source =
      ../../src/lua/plugins/ui/mini-basics.lua;
  };
}
