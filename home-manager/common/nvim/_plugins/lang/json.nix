{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      vscode-langservers-extracted
      nodePackages.prettier
    ];
    plugins = with pkgs.vimPlugins; [
      conform-nvim
      nvim-lspconfig
      SchemaStore-nvim
    ];
  };
  xdg.configFile = {
    "nvim/ftplugin/json.lua".source =
      ../../src/ftplugin/json.lua;
    "nvim/lua/plugins/lang/json.lua".source =
      ../../src/lua/plugins/lang/json.lua;
    "nvim/lsp/jsonls.lua".source =
      ../../src/lsp/jsonls.lua;
  };
}
