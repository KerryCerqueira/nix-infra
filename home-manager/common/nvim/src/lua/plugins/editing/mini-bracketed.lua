if false then
	require("lazy")
	require("which-key")
end

---@type LazySpec
return {
	{
		"echasnovski/mini.bracketed",
		event = "BufEnter",
		opts = {},
		version = false,
	},
	{
		"folke/which-key.nvim",
		optional = true,
		opts_extend = { "spec" },
		---@type wk.Opts
		opts = {
			spec = {
				{ "]", group = "iteration" },
				{ "[", group = "reverse iteration" },
			},
		},
	},
}
