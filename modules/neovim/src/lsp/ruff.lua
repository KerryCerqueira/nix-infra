---@type vim.lsp.Config
return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	keys = {
		{
			"<localleader>co",
			function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.organizeImports" },
						diagnostics = {},
					},
				})
			end,
			desc = "Organize Imports",
		},
	},
	init_options = {
		settings = {
			lineLength = 79,
			format = {
				docstringCodeFormat = true,
			},
		},
	},
}
