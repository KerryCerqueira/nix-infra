---@type LazySpec
return {
	{
		"echasnovski/mini.bracketed",
		event = "BufEnter",
		opts = {},
		version = false,
	},
	{
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
	},
	{
		"echasnovski/mini.splitjoin",
		event = "BufEnter",
		version = false,
		opts = {},
	},
	{
		"echasnovski/mini.surround",
		event = "BufEnter",
		specs = {
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
		"echasnovski/mini.trailspace",
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
		version = false,
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "VeryLazy",
		opts = {
			keymaps = {
				useDefaults = true,
			},
		},
		keys = {
			{
				"il",
				'<cmd>lua require("various-textobjs").mdLink("inner")<CR>',
				mode = { "x", "o" },
				ft = md_ft,
				desc = "MD link (inner)",
			},
			{
				"al",
				'<cmd>lua require("various-textobjs").mdLink("outer")<CR>',
				mode = { "x", "o" },
				ft = md_ft,
				desc = "MD link (outer)",
			},
			{
				"ie",
				'<cmd>lua require("various-textobjs").mdEmphasis("inner")<CR>',
				mode = { "x", "o" },
				ft = md_ft,
				desc = "MD emphasis (inner)",
			},
			{
				"ae",
				'<cmd>lua require("various-textobjs").mdEmphasis("outer")<CR>',
				mode = { "x", "o" },
				ft = md_ft,
				desc = "MD emphasis (outer)",
			},
			{
				"iC",
				'<cmd>lua require("various-textobjs").mdFencedCodeBlock("inner")<CR>',
				mode = { "x", "o" },
				ft = md_ft,
				desc = "MD code block (inner)",
			},
			{
				"aC",
				'<cmd>lua require("various-textobjs").mdFencedCodeBlock("outer")<CR>',
				mode = { "x", "o" },
				ft = md_ft,
				desc = "MD code block (outer)",
			},
		},
	},
	{
		"gbprod/substitute.nvim",
		specs = {
			"rachartier/tiny-glimmer.nvim",
			opts = {
				support = { substitute = { enabled = true } },
			},
			optional = true,
		},
		event = "BufEnter",
		keys = {
			{
				"s",
				function()
					require("substitute").operator()
				end,
				desc = "subtitution operator",
				{ noremap = true },
			},
			{
				"ss",
				function()
					require("substitute").line()
				end,
				desc = "subtitute line",
				{ noremap = true },
			},
			{
				"s",
				function()
					require("substitute").visual()
				end,
				desc = "subtitute visual",
				mode = "x",
				{ noremap = true },
			},
			{
				"sx",
				function()
					require("substitute.exchange").operator()
				end,
				desc = "exchange operator",
				{ noremap = true },
			},
			{
				"sxx",
				function()
					require("substitute.exchange").line()
				end,
				desc = "exchange line",
				{ noremap = true },
			},
			{
				"sx",
				function()
					require("substitute.exchange").visual()
				end,
				desc = "exchange visual",
				mode = "x",
				{ noremap = true },
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
}
