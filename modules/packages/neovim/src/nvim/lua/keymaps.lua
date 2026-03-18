local wk = require("which-key")

return {
	setup = function()
		wk.add(
			{
				{
					"<Esc>",
					"<cmd>nohlsearch<CR>",
					desc = "Clear highlight",
				},
				{
					"gD",
					vim.lsp.buf.declaration,
					desc = "Go to declaration"
				},
				{
					"<Leader>ca",
					vim.lsp.buf.code_action,
					desc = "See available code actions"
				},
				{
					"<Leader>rn",
					vim.lsp.buf.rename,
					desc = "Smart rename"
				},
				{
					"<Leader>d",
					vim.diagnostic.open_float,
					desc = "Show line diagnostics"
				},
				{
					"<Leader>rs",
					":LspRestart<CR>",
					desc = "Restart LSP"
				},
				{
					"<leader>b",
					group = "buffers",
					expand = function()
						return require("which-key.extras").expand.buf()
					end
				},
				{
					"C-w",
					group = "windows",
					expand = function()
						return require("which-key.extras").expand.win()
					end
				},
			}
		)
	end,
}
