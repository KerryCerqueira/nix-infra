return {
	'echasnovski/mini.trailspace',
	event = "BufEnter",
	keys = {
		{
			"<leader>gt",
			function()
				require("mini.trailspace").trim()
				require("mini.trailspace").trim_last_lines()
				vim.notify("Trimmed whitespace.")
			end,
			desc = "Trim whitespace.",
		},
	},
	opts = {},
	version = false
}
