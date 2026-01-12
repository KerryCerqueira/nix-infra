{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      alejandra
      nil
    ];
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      conform-nvim
    ];
  };
  xdg.configFile = {
    "nvim/ftplugin/nix.lua".source = ../../src/ftplugin/nix.lua;
    "nvim/lua/plugins/lang/nix.lua".source = ../../src/lua/plugins/lang/nix.lua;
    "nvim/lsp/nil_ls.lua".source = ../../src/lsp/nil_ls.lua;
  };
}
