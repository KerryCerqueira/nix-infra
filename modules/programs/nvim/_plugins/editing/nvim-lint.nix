{pkgs, ...}: {
  programs.neovim.plugins = [pkgs.vimPlugins.nvim-lint];
  programs.neovim.lazyNixCompat.idOverrides."nvim-lint" = "mfussenegger/nvim-lint";
  xdg.configFile = {
    "nvim/lua/plugins/editing/nvim-lint.lua".source =
      ../../src/lua/plugins/editing/nvim-lint.lua;
  };
}
