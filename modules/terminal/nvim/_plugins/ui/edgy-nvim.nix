{pkgs, ...}: {
  programs.neovim.plugins = [pkgs.vimPlugins.edgy-nvim];
  xdg.configFile = {
    "nvim/lua/plugins/ui/edgy-nvim.lua".source =
      ../../src/lua/plugins/ui/edgy-nvim.lua;
  };
}
