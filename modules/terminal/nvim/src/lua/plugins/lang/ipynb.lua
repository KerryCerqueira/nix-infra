if false then
	require("lazy")
	require("which-key")
end

---@type LazySpec
return {
	{
		'jmbuhr/otter.nvim',
		ft = { "markdown", "quarto" },
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		opts = {},
	},
	{
		"quarto-dev/quarto-nvim",
		dependencies = { 'jmbuhr/otter.nvim', },
		ft = { "quarto" },
		init = function()
			vim.api.nvim_create_autocmd(
				"User",
				{
					pattern = "MoltenInitPost",
					group = vim.api.nvim_create_augroup("QuartoMoltenInit", {}),
					callback = function(ev)
						if vim.bo[ev.buf].filetype == "quarto" then
							vim.notify("Setting quarto keybinds for molten...")
							vim.keymap.set(
								"n",
								"<localleader>rc",
								require("quarto.runner").run_cell,
								{ desc = "run cell", silent = true, buffer = ev.buf }
							)
							vim.keymap.set(
								"n",
								"<localleader>rh",
								require("quarto.runner").run_above,
								{ desc = "run cell and above", silent = true, buffer = ev.buf }
							)
							vim.keymap.set(
								"n",
								"<localleader>Ra",
								require("quarto.runner").run_all,
								{ desc = "run all cells", silent = true, buffer = ev.buf }
							)
							vim.keymap.set(
								"n",
								"<localleader>RA",
								function()require("quarto.runner").run_all(true)end,
								{ desc = "run all cells of all languages", silent = true, buffer = ev.buf }
							)
						end
					end,
				}
			)
			vim.api.nvim_create_autocmd(
				"User",
				{
					pattern = "MoltenDeinitPost",
					group = vim.api.nvim_create_augroup("QuartoMoltenDeinit", {}),
					callback = function(ev)
						if vim.bo[ev.buf].filetype == "quarto" then
							vim.keymap.del("n", "<localleader>rc", { buffer = ev.buf })
							vim.keymap.del("n", "<localleader>rh", { buffer = ev.buf })
							vim.keymap.del("n", "<localleader>Ra", { buffer = ev.buf })
							vim.keymap.del("n", "<localleader>RA", { buffer = ev.buf })
						end
					end,
				}
			)
		end,
		opts = {
			lspFeatures = {
				enabled = true,
				chunks = "curly",
			},
			codeRunner = {
				enabled = true,
				default_method = "molten",
			},
		},
	},
	{
		"HakonHarnes/img-clip.nvim",
		ft = { "markdown", "quarto", "latex" },
		opts = {
			default = {
				dir_path = "img",
			},
			filetypes = {
				markdown = {
					url_encode_path = true,
					template = "![$CURSOR]($FILE_PATH)",
					drag_and_drop = {
						download_images = false,
					},
				},
				quarto = {
					url_encode_path = true,
					template = "![$CURSOR]($FILE_PATH)",
					drag_and_drop = {
						download_images = false,
					},
				},
			},
		},
		config = function(_, opts)
			require("img-clip").setup(opts)
			vim.keymap.set(
				"n",
				"<leader>ii",
				":PasteImage<cr>",
				{ desc = "insert image from clipboard" }
			)
		end,
	},
	{
		"benlubas/molten-nvim",
		dependencies = { "folke/snacks.nvim" },
		ft = { "python", "markdown", "quarto" },
		keys = {
			{
				"<localleader>mi",
				"<cmd>MoltenInit<CR>",
				desc = "Initialize the plugin",
			},
			{
				"<localleader>md",
				"<cmd>MoltenDeinit<CR>",
				desc = "Stop molten",
			},
		},
		init = function()
			vim.g.molten_image_provider = "snacks.nvim"
			vim.g.molten_auto_image_popup = true
			vim.g.molten_auto_open_html_in_browser = true
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_output_show_more = true
			vim.g.molten_tick_rate = 200
			vim.api.nvim_create_autocmd(
				"User",
				{
					pattern = "MoltenInitPost",
					group = vim.api.nvim_create_augroup("MoltenInit", {}),
					callback = function(ev)
						vim.notify("Setting molten keybinds...")
						vim.keymap.set(
							"n",
							"<localleader>ro",
							":MoltenEvaluateOperator<CR>",
							{ silent = true, desc = "run operator selection", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"<localleader>rr",
							":MoltenEvaluateLine<CR>",
							{ silent = true, desc = "evaluate line", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"<localleader>ce",
							":MoltenReevaluateCell<CR>",
							{ silent = true, desc = "re-evaluate cell", buffer = ev.buf }
						)
						vim.keymap.set(
							"v",
							"<localleader>r",
							":<C-u>MoltenEvaluateVisual<CR>gv",
							{silent = true, desc = "evaluate visual selection", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"<localleader>cd",
							":MoltenDelete<CR>",
							{ silent = true, desc = "molten delete cell", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"<localleader>ch",
							":MoltenHideOutput<CR>",
							{ silent = true, desc = "hide output", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"<localleader>cs",
							":noautocmd MoltenEnterOutput<CR>",
							{ silent = true, desc = "show/enter output", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"<localleader>ms",
							":noautocmd MoltenEnterOutput<CR>",
							{ silent = true, desc = "show/enter output", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"<localleader>mp",
							":MoltenImagePopup<CR>",
							{ silent = true, desc = "molten image popup", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"<localleader>mb",
							":MoltenOpenInBrowser<CR>",
							{ silent = true, desc = "molten open in browser", buffer = ev.buf }
						)
						vim.keymap.set(
							"n",
							"<localleader>mh",
							":MoltenHideOutput<CR>",
							{ silent = true, desc = "hide output", buffer = ev.buf }
						)
					end,
				}
			)
			vim.api.nvim_create_autocmd(
				"User",
				{
					pattern = "MoltenDeinitPost",
					group = vim.api.nvim_create_augroup("MoltenDeInit", {}),
					callback = function(ev)
						vim.keymap.del("n", "<localleader>ro", { buffer = ev.buf })
						vim.keymap.del("n", "<localleader>rr", { buffer = ev.buf })
						vim.keymap.del("n", "<localleader>ce", { buffer = ev.buf })
						vim.keymap.del("v", "<localleader>r", { buffer = ev.buf })
						vim.keymap.del("n", "<localleader>cd", { buffer = ev.buf })
						vim.keymap.del("n", "<localleader>ch", { buffer = ev.buf })
						vim.keymap.del("n", "<localleader>cs", { buffer = ev.buf })
						vim.keymap.del("n", "<localleader>ms", { buffer = ev.buf })
						vim.keymap.del("n", "<localleader>mp", { buffer = ev.buf })
						vim.keymap.del("n", "<localleader>mb", { buffer = ev.buf })
						vim.keymap.del("n", "<localleader>mh", { buffer = ev.buf })
					end,
				}
			)
		end,
	},
	{
		"folke/which-key.nvim",
		optional = true,
		opts_extend = { "spec" },
		---@type wk.Opts
		opts = {
			spec = {
				{ "<localleader>m", group = "molten" },
			},
		},
	},
	{
		"folke/snacks.nvim",
		optional = true,
		---@type snacks.Config
		opts = {
			image = { enabled = true },
		},
	},
}
