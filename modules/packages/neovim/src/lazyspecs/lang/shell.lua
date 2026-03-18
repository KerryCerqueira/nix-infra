if false then
	require("lazy")
end

---@type LazySpec
return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				bash = { "shellcheck" },
				sh = { "shellcheck" },
				zsh = { "shellcheck" },
			},
		},
	}
}
