return {
	{
		'mcauley-penney/visual-whitespace.nvim',
		event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
		opts = {
			space_char = "␣",
			tab_char = "󰌒";
		},
	},
}
