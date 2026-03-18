	return {
		"echasnovski/mini.comment",
		version = false,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			opts = { enable_autocmd = false },
		},
		opts = {
			custom_commentstring = function()
				local module = require("ts_context_commentstring")
				return module.calculate_commentstring() or vim.bo.commentstring
			end,
		},
	}
