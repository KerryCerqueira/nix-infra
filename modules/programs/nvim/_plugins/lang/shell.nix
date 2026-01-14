{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      bash-language-server
      fish-lsp
      shellcheck
    ];
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      conform-nvim
    ];
  };
  xdg.configFile = {
    "nvim/ftplugin/bash.lua".source =
      ../../src/ftplugin/bash.lua;
    "nvim/ftplugin/sh.lua".source =
      ../../src/ftplugin/sh.lua;
    "nvim/ftplugin/zsh.lua".source =
      ../../src/ftplugin/zsh.lua;
    "nvim/lua/plugins/lang/shell.lua".source =
      ../../src/lua/plugins/lang/shell.lua;
    "nvim/lsp/bashls.lua".source =
      ../../src/lsp/bashls.lua;
    "nvim/lsp/fish_lsp.lua".source =
      ../../src/lsp/fish_lsp.lua;
  };
}
