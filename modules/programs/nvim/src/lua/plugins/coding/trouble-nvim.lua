if false then
	require("lazy")
	require("which-key")
	require("trouble")
end

---@type LazySpec
return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false win.position=left<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=left<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle win.position=bottom<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
		---@type trouble.Config
		opts = {
			open_no_results = true,
		},
	},
	{
		"folke/edgy.nvim",
		optional = true,
		opts_extend = { "bottom", "left", "right" },
		---@type Edgy.Config
		opts = {
			bottom = {
				{
					title = "Diagnostics",
					ft = "trouble",
					filter = function(_, win)
						return vim.w[win].trouble
							and vim.w[win].trouble.position == "bottom"
							and vim.w[win].trouble.type == "split"
							and vim.w[win].trouble.relative == "editor"
							and vim.w[win].trouble.mode == "diagnostics"
							and not vim.w[win].trouble_preview
					end,
				},
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
				{ "<Leader>x", group = "trouble" },
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"folke/trouble.nvim",
		},
		optional = true,
		opts = {
			actions = {
				files = {
					["ctrl-t"] = require("trouble.sources.fzf").actions.open
				},
			},
		}
	},
}
