{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      markdownlint-cli2
      marksman
      python312Packages.pylatexenc
      nodePackages.prettier
    ];
    plugins = with pkgs.vimPlugins; [
      conform-nvim
      img-clip-nvim
      # nvim-lint
      nvim-lspconfig
      render-markdown-nvim
      snacks-nvim
    ];
  };
  xdg.configFile = {
    "nvim/ftplugin/markdown.lua".source =
      ../../src/ftplugin/markdown.lua;
    "nvim/lua/plugins/lang/markdown.lua".source =
      ../../src/lua/plugins/lang/markdown.lua;
    "nvim/lsp/marksman.lua".source =
      ../../src/lsp/marksman.lua;
  };
}
