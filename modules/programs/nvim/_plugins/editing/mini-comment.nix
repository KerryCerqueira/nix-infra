{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    mini-comment
    nvim-ts-context-commentstring
  ];
  xdg.configFile = {
    "nvim/lua/plugins/editing/mini-comment.lua".source =
      ../../src/lua/plugins/editing/mini-comment.lua;
  };
}
