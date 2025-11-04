if false then
	require("lazy")
	require("blink.cmp")
	require("lazydev")
end

---@type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = { ensure_installed = { "luap", "luau", "luadoc", "lua" } },
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		---@type lazydev.Config
		opts = {},
	},
	{
		"saghen/blink.cmp",
		optional = true,
		opts_extend = { "sources.default" },
		---@type blink.cmp.Config
		opts = {
			sources = {
				per_filetype = {
					lua = {
						inherit_defaults = true,
						"lazydev",
					},
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		},
	},
	{
		"folke/neodev.nvim",
		enabled = false,
	},
}
