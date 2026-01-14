{pkgs, ...}: {
  home.packages = with pkgs; [
    zathura
  ];
  programs.neovim = {
    extraPackages = with pkgs; [
      texlab
    ];
    plugins = with pkgs.vimPlugins; [
      vimtex
      img-clip-nvim
      nvim-treesitter.withAllGrammars
      nvim-lint
    ];
  };
  xdg.configFile = {
    "nvim/ftplugin/tex.lua".source = ../../src/ftplugin/tex.lua;
    "nvim/lua/plugins/lang/tex.lua".source = ../../src/lua/plugins/lang/tex.lua;
    "nvim/lsp/texlab.lua".source = ../../src/lsp/texlab.lua;
  };
}
