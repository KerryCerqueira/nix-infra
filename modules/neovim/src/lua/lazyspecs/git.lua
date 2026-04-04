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
			"ibhagwan/fzf-lua",
		},
		cmd = "Neogit",
		keys = {
			{
				"<Leader>gd",
				"<cmd> DiffviewOpen<cr>",
				desc = "Diff against index",
			},
			{
				"<Leader>gD",
				"<cmd> DiffviewOpen HEAD<cr>",
				desc = "Diff against HEAD",
			},
			{
				"<Leader>gh",
				"<cmd> DiffviewFileHistory<cr>",
				desc = "View git file history",
			},
			{
				"<Leader>gg",
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
				{ "<Leader>g", group = "git" },
			},
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "Kaiser-Yang/blink-cmp-git" },
		},
		optional = true,
		opts_extend = { "sources.default" },
		---@type blink.cmp.Config
		opts = {
			sources = {
				default = { "git" },
				providers = {
					git = {
						score_offset = 100,
						enabled = function()
							return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
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
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		---@type Gitsigns.config
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end
				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")
				map("n", "]H", function()
					gs.nav_hunk("last")
				end, "Last Hunk")
				map("n", "[H", function()
					gs.nav_hunk("first")
				end, "First Hunk")
				map({ "n", "v" }, "<Leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<Leader>gx", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<Leader>gS", gs.stage_buffer, "Stage Buffer")
				map("n", "<Leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<Leader>gX", gs.reset_buffer, "Reset Buffer")
				map("n", "<Leader>gp", gs.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<Leader>gb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<Leader>gB", function()
					gs.blame()
				end, "Blame Buffer")
				map("n", "<Leader>gd", gs.diffthis, "Diff This")
				map("n", "<Leader>gD", function()
					gs.diffthis("~")
				end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
				map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
	{
		"ibhagwan/fzf-lua",
		keys = {
			{
				"<Leader>fg",
				"<cmd>FzfLua git_files<cr>",
				desc = "Find Files (git-files)",
			},
			{
				"<Leader>gc",
				"<cmd>FzfLua git_commits<CR>",
				desc = "Commits",
			},
			{
				"<Leader>gs",
				"<cmd>FzfLua git_status<CR>",
				desc = "Status",
			},
		},
	},
}
