---@type vim.lsp.Config
return {
	cmd = { 'yaml-language-server', '--stdio' },
	filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
	root_markers = { '.git' },
	befoe_init = function(_, cfg)
		cfg.settings.yaml.schemas = vim.tbl_deep_extend(
			"force",
			cfg.settings.yaml.schemas or {},
			require("schemastore").yaml.schemas()
		)
	end,
	settings = {
		-- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
		redhat = { telemetry = { enabled = false } },
		-- formatting disabled by default in yaml-language-server; enable it
		yaml = {
			keyOrdering = false,
			format = {
				enable = true,
			},
			validate = true,
			schemaStore = {
				-- Must disable built-in schemaStore support to use
				-- schemas from SchemaStore.nvim plugin
				enable = false,
				-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
				url = "",
			},
		},
	},
	on_init = function(client)
		--- https://github.com/neovim/nvim-lspconfig/pull/4016
		--- Since formatting is disabled by default if you check `client:supports_method('textDocument/formatting')`
		--- during `LspAttach` it will return `false`. This hack sets the capability to `true` to facilitate
		--- autocmd's which check this capability
		client.server_capabilities.documentFormattingProvider = true
	end,
	capabilities = {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	},
}
