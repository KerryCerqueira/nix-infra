if false then
	require("lazy")
end

---@type LazySpec
return {
	{
		"b0o/SchemaStore.nvim",
		lazy = true,
		version = false,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				json = { "prettier" },
			},
		},
	},
}
