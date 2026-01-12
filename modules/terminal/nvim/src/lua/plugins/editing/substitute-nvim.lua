return {
	{
		"gbprod/substitute.nvim",
		event = "BufEnter",
		keys = {
			{
				"s",
				function()
					require("substitute").operator()
				end,
				desc = "subtitution operator",
				{ noremap = true},
			},
			{
				"ss",
				function()
					require("substitute").line()
				end,
				desc = "subtitute line",
				{ noremap = true},
			},
			{
				"s",
				function()
					require("substitute").visual()
				end,
				desc = "subtitute visual",
				mode = "x",
				{ noremap = true},
			},
			{
				"sx",
				function()
					require("substitute.exchange").operator()
				end,
				desc = "exchange operator",
				{ noremap = true},
			},
			{
				"sxx",
				function()
					require("substitute.exchange").line()
				end,
				desc = "exchange line",
				{ noremap = true},
			},
			{
				"sx",
				function()
					require("substitute.exchange").visual()
				end,
				desc = "exchange visual",
				mode = "x",
				{ noremap = true},
			},
		},
		opts = function()
			return {
				yank_substituted_text = true,
				on_substitute = require("tiny-glimmer.support.substitute").substitute_cb,
				highlight_substituted_text = {
					enabled = false,
				},
			}
		end,
	},
	{
		"rachartier/tiny-glimmer.nvim",
		opts = {
			support = { substitute = { enabled = true, }, },
		},
		optional = true,
	},
}
