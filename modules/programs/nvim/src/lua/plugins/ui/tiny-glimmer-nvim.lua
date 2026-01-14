return {
	{
		"rachartier/tiny-glimmer.nvim",
		event = "VeryLazy",
		priority = 10,
		opts = {
			enabled = true,
			disable_warnings = true,
			overwrite = {
				auto_map = true,
				search = { enabled = true, },
				paste = { enabled = true, },
				undo = { enabled = true, },
				redo = { enabled = true, },
				presets = { pulsar = { enabled = true, }, },
			},
		},
	},
}
