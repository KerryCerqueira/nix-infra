if false then
	require("lazy")
	require("which-key")
end

---@type LazySpec
return {
	{
		"echasnovski/mini.surround",
		event = "BufEnter",
		init = function()
			vim.keymap.set("n", "S", "<Nop>")
		end,
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
				suffix_last = "l",
				suffix_next = "n",
			},
		},
	},
	{
		"folke/which-key.nvim",
		optional = true,
		opts_extend = { "spec" },
		---@type wk.Opts
		opts = {
			spec = {
				{ "gs", group = "surround" },
			},
		},
	},
}
