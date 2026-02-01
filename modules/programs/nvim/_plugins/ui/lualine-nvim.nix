{pkgs, ...}: {
  xdg.configFile = {
    "nvim/lua/plugins/ui/lualine-nvim.lua".source =
      ../../src/lua/plugins/ui/lualine-nvim.lua;
  };
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      lualine-nvim
      lualine-lsp-progress
    ];
  };
}
