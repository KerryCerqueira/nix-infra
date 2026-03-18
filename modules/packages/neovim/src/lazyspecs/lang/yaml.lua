if false then
	require("lazy")
end

---@type LazySpec
return {
	{
		"b0o/SchemaStore.nvim",
		lazy = true,
		version = false, -- last release is way too old
	},
	{
		'stevearc/conform.nvim',
		optional = true,
		opts = {
			formatters_by_ft = {
				yaml = { "prettier" },
			},
		},
	},
}
