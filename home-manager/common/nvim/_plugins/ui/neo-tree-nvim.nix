{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    neo-tree-nvim
    nui-nvim
    nvim-web-devicons
    plenary-nvim
    snacks-nvim
  ];
  xdg.configFile."nvim/lua/plugins/ui/neo-tree-nvim.lua".source =
    ../../src/lua/plugins/ui/neo-tree-nvim.lua;
}
