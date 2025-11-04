{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    which-key-nvim
    mini-icons
  ];
  xdg.configFile = {
    "nvim/lua/plugins/ui/which-key-nvim.lua".source =
      ../../src/lua/plugins/ui/which-key-nvim.lua;
  };
}
