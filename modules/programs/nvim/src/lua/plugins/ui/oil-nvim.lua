if false then
	require("lazy")
	require("oil")
end

---@type LazySpec
return {
	{
		"stevearc/oil.nvim",
		---@type oil.SetupOpts
		keys = {
			{
				"-",
				"<cmd>Oil --float<CR>",
				desc = "Explorer NeoTree (root dir)",
			},
		},
		opts = {
			keymaps = {
				["?"] = { "actions.show_help", mode = "n" },
				["q"] = { "actions.close", mode = "n" },
				["<C-r>"] = "actions.refresh",
				["\\T"] = { "actions.toggle_trash", mode = "n" },
			},
		},
		dependencies = {
			"echasnovski/mini.icons",
		},
		lazy = false,
	},
	{
		"benomahony/oil-git.nvim",
		dependencies = { "stevearc/oil.nvim" },
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {}
	},
}
