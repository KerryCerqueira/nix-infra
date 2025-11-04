return {
	'stevearc/conform.nvim',
	optional = true,
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({async = true})
			end,
			desc = "Format (conform-nvim)",
		},
	},
	opts = {
		formatters = {
			prettier = {
				prepend_args = {
					"--print-width 72",
					"--prose-wrap always"
				},
			},
		},
	},
}
