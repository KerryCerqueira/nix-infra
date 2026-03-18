if false then
	require("lazy")
	require("which-key")
	require("neogit")
	require("blink.cmp")
end

---@type LazySpec
return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"sindrets/diffview.nvim",
				cmd = { "DiffviewOpen", "DiffviewOpen" },
			},
			"nvim-telescope/telescope.nvim",
		},
		cmd = "Neogit",
		keys = {
			{
				"<Leader>Gd",
				"<cmd> DiffviewOpen<cr>",
				desc = "Diff against index",
			},
			{
				"<Leader>GD",
				"<cmd> DiffviewOpen HEAD<cr>",
				desc = "Diff against HEAD",
			},
			{
				"<Leader>Gh",
				"<cmd> DiffviewFileHistory<cr>",
				desc = "View git file history",
			},
			{
				"<Leader>Gg",
				function()
					require("neogit").open({ cwd = "%:p:h" })
				end,
				desc = "Git status",
			},
		},
		---@type NeogitConfig
		opts = {
			graph_style = "kitty",
			kind = "floating",
			floating = {
				height = 0.8,
				width = 0.9,
			},
		},
	},
	{
		"folke/which-key.nvim",
		optional = true,
		opts_extend = { "spec" },
		---@type wk.Opts
		opts = {
			spec = {
				{ "<leader>G", group = "git" },
			},
		},
	},
	{
		'saghen/blink.cmp',
		dependencies = {
			{ 'Kaiser-Yang/blink-cmp-git', },
		},
		optional = true,
		opts_extend = { "sources.default" },
		---@type blink.cmp.Config
		opts = {
			sources = {
				default = { "git", },
				providers = {
					git = {
						score_offset = 100,
						enabled = function()
							return vim.tbl_contains(
								{ "octo", "gitcommit", "markdown" },
								vim.bo.filetype
							)
						end,
						name = "git",
						module = "blink-cmp-git",
						opts = {
							commit = {},
							git_centers = {
								github = {},
							},
						},
					},
				},
			},
		},
	}
}
