if false then
	require("lazy")
end

---@type LazySpec
return {
	{
		'stevearc/conform.nvim',
		optional = true,
		opts = {
			formatters_by_ft = {
				toml = { "prettier" },
			},
		},
	},
}
