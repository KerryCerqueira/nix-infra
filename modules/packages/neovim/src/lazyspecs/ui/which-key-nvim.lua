if false then
	require("lazy")
	require("which-key")
end

---@type LazySpec
return {
	"folke/which-key.nvim",
	dependencies = { "echasnovski/mini.icons" },
	event = "VeryLazy",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show()
			end,
			desc = "Show Keymaps (which-key)",
		},
		{
			"<c-w><space>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Window Hydra Mode (which-key)",
		},
	},
	opts_extend = { "spec" },
	---@type wk.Opts
	opts = {
		preset = "modern",
		spec = {
			{ "\\", group = "toggle" },
		},
	},
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
}
