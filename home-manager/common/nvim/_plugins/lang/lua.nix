{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      stylua
      lua-language-server
    ];
    plugins = with pkgs.vimPlugins; [
      lazydev-nvim
      nvim-treesitter.withAllGrammars
      conform-nvim
    ];
  };
  xdg.configFile = {
    "nvim/ftplugin/lua.lua".source = ../../src/ftplugin/lua.lua;
    "nvim/lua/plugins/lang/lua.lua".source = ../../src/lua/plugins/lang/lua.lua;
    "nvim/lsp/lua_ls.lua".source = ../../src/lsp/lua_ls.lua;
  };
}
