{pkgs, ...}: {
  home.packages = with pkgs; [
    vectorcode
  ];
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      codecompanion-nvim
      codecompanion-history-nvim
      nvim-treesitter.withAllGrammars
      plenary-nvim
      vectorcode-nvim
    ];
    extraPackages = with pkgs; [
      curl
      ripgrep
    ];
  };
  xdg.configFile = {
    "nvim/lua/plugins/ai/codecompanion-nvim.lua".source =
      ../../src/lua/plugins/ai/codecompanion-nvim.lua;
  };
}
