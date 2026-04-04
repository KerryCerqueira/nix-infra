return {
	{
		"mfussenegger/nvim-lint",
		config = function(_, opts)
			require("lint").linters_by_ft = opts.linters_by_ft or {}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>gf",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format (conform-nvim)",
			},
		},
		opts = {
			formatters = {
				prettier = {
					prepend_args = {
						"--print-width 72",
						"--prose-wrap always",
					},
				},
			},
		},
	},
}
