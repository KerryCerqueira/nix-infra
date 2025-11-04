{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      curl
      git
      lynx
      ripgrep
    ];
    extraLuaPackages = ps: [
      ps.tiktoken_core
    ];
    plugins = with pkgs.vimPlugins; [
      CopilotChat-nvim
      copilot-lua
      nvim-treesitter.withAllGrammars
      plenary-nvim
    ];
  };
  xdg.configFile = {
    "nvim/lua/plugins/ai/copilotchat-nvim.lua".source =
      ../../src/lua/plugins/ai/copilotchat-nvim.lua;
  };
}
