{pkgs, ...}: {
  programs.neovim = {
    plugins = [pkgs.vimPlugins.obsidian-nvim];
    extraPackages = [pkgs.markdown-oxide];
  };
  xdg.configFile = {
    "nvim/lua/plugins/editing/obsidian-nvim.lua".source =
      ../../src/lua/plugins/editing/obsidian-nvim.lua;
  };
}
