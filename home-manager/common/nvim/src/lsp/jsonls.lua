---@type vim.lsp.Config
return {
	cmd = { 'vscode-json-language-server', '--stdio' },
	filetypes = { 'json', 'jsonc' },
	before_init = function(_, cfg)
		---@diagnostic disable-next-line: inject-field
		cfg.settings.json.schemas = cfg.settings.json.schemas or {}
		vim.list_extend(cfg.settings.json.schemas, require("schemastore").json.schemas())
	end,
	init_options = {
		provideFormatter = true,
	},
	settings = {
		json = {
			format = {
				enable = true,
			},
			validate = { enable = true },
		},
	},
	root_markers = { '.git' },
}
