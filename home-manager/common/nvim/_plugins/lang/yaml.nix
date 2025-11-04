{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      nodePackages.prettier
      yaml-language-server
    ];
    plugins = with pkgs.vimPlugins; [
      SchemaStore-nvim
      conform-nvim
      nvim-lspconfig
    ];
  };
  xdg.configFile = {
    "nvim/ftplugin/yaml.lua".source =
      ../../src/ftplugin/yaml.lua;
    "nvim/lua/plugins/lang/yaml.lua".source =
      ../../src/lua/plugins/lang/yaml.lua;
    "nvim/lsp/yamlls.lua".source =
      ../../src/lsp/yamlls.lua;
  };
}
