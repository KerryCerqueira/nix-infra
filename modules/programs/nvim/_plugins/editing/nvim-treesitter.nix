{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      (nvim-treesitter-context.overrideAttrs (old: {dependencies = [];}))
      (nvim-treesitter-endwise.overrideAttrs (old: {dependencies = [];}))
      (nvim-treesitter-textobjects.overrideAttrs (old: {dependencies = [];}))
    ];
  };
  xdg.configFile = {
    "nvim/lua/plugins/editing/nvim-treesitter.lua".source =
      ../../src/lua/plugins/editing/nvim-treesitter.lua;
    "nvim/lua/plugins/nixcompat/nvim-treesitter.lua".text =
      # lua
      ''
        return {
        	"nvim-treesitter/nvim-treesitter",
        	optional = true,
        	opts = {
        		auto_install = false,
        		ensure_installed = {},
        	},
        	build = nil
        }
      '';
  };
}
