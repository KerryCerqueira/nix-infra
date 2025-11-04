return {
	"chrisgrieser/nvim-various-textobjs",
	event = "VeryLazy",
	init = function()
		vim.api.nvim_create_autocmd(
			"FileType", {
				pattern = {
					"quarto",
					"qmd",
					"rmarkdown",
					"pandoc",
					"markdown.pandoc",
					"codecompanion",
				},
				callback = function()
					vim.keymap.set(
						{ "o", "x" },
						"il",
						'<cmd>lua require("various-textobjs").mdLink("inner")<CR>',
						{ buffer = true, silent = true, desc = "markdown link" }
					)
					vim.keymap.set(
						{ "o", "x" },
						"al",
						'<cmd>lua require("various-textobjs").mdLink("outer")<CR>',
						{ buffer = true, silent = true, desc = "markdown link" }
					)
					vim.keymap.set(
						{ "o", "x" },
						"ie",
						'<cmd>lua require("various-textobjs").mdEmphasis("inner")<CR>',
						{ buffer = true, silent = true, desc = "markdown emphasis" }
					)
					vim.keymap.set(
						{ "o", "x" },
						"ae",
						'<cmd>lua require("various-textobjs").mdEmphasis("outer")<CR>',
						{ buffer = true, silent = true, desc = "markdown emphasis" }
					)
					vim.keymap.set(
						{ "o", "x" },
						"iC",
						'<cmd>lua require("various-textobjs").mdFencedCodeBlock("inner")<CR>',
						{ buffer = true, silent = true, desc = "code block" }
					)
					vim.keymap.set(
						{ "o", "x" },
						"aC",
						'<cmd>lua require("various-textobjs").mdFencedCodeBlock("outer")<CR>',
						{ buffer = true, silent = true, desc = "code block" }
					)
				end,
			}
		)
	end,
	opts = {
		keymaps = {
			useDefaults = true
		}
	},
}
