---@type LazySpec
return {
	{
		"nvim-lualine/lualine.nvim",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = {
			options = {
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				theme = "auto",
				globalstatus = true,
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "starter" },
					winbar = { "neominimap", "trouble", "neo-tree" },
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },

				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
						},
					},
				},
				lualine_x = {
					"lsp_status",
					{
						"diff",
						symbols = {
							added = " ",
							modified = " ",
							removed = " ",
						},
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
			},
			winbar = {
				lualine_a = {
					"filename",
				},
				lualine_y = {
					{ "filetype", separator = "" },
					{ "filesize", separator = "" },
					"encoding",
				},
			},
			inactive_winbar = {
				lualine_b = {
					"filename",
				},
				lualine_x = {
					{ "filetype", separator = "" },
					{ "filesize", separator = "" },
					"encoding",
				},
			},
			extensions = { "lazy", "quickfix", "trouble", "fzf" },
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		specs = {
			{
				"folke/which-key.nvim",
				opts_extend = { "spec" },
				optional = true,
				---@type wk.Opts
				opts = {
					spec = {
						{ "<Leader>n", group = "notifications" },
					},
				},
			},
			{
				"folke/edgy.nvim",
				optional = true,
				opts_extend = { "bottom", "left", "right" },
				---@type Edgy.Config
				opts = {
					bottom = {
						{
							title = "%{b:snacks_terminal.id}: %{b:term_title}",
							ft = "snacks_terminal",
							size = { height = 8 },
							filter = function(_, win)
								return vim.w[win].snacks_win
									and vim.w[win].snacks_win.position == "bottom"
									and vim.w[win].snacks_win.relative == "editor"
									and not vim.w[win].trouble_preview
							end,
						},
					},
					left = {
						{
							title = "LSP Defs/Refs/Decs",
							ft = "trouble",
							filter = function(_, win)
								return vim.w[win].trouble
									and vim.w[win].trouble.position == "left"
									and vim.w[win].trouble.type == "split"
									and vim.w[win].trouble.relative == "editor"
									and vim.w[win].trouble.mode == "lsp"
									and not vim.w[win].trouble_preview
							end,
						},
						{
							title = "",
							ft = "trouble",
							filter = function(_, win)
								return vim.w[win].trouble
									and vim.w[win].trouble.position == "left"
									and vim.w[win].trouble.type == "split"
									and vim.w[win].trouble.relative == "editor"
									and vim.w[win].trouble.mode == "symbols"
									and not vim.w[win].trouble_preview
							end,
						},
					},
				},
			},
		},
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			image = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = {
				enabled = true,
				folds = {
					open = true,
					git_hl = true,
				},
			},
			styles = {
				notification = {
					wo = { wrap = true },
				},
			},
			words = { enabled = true },
		},
		keys = {
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>Z",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom",
			},
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>fs",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			{
				"<leader>nh",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>rf",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File",
			},
			{
				"<leader>nd",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			{
				"<c-/>",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command
					Snacks.toggle.option("spell", { name = "Spelling" }):map("\\s")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("\\w")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("\\r")
					Snacks.toggle.diagnostics():map("\\d")
					Snacks.toggle.line_number():map("\\n")
					Snacks.toggle
						.option("conceallevel", {
							off = 0,
							on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
						})
						:map("\\L")
					Snacks.toggle.treesitter():map("\\th")
					Snacks.toggle.inlay_hints():map("\\H")
					Snacks.toggle.indent():map("\\g")
					Snacks.toggle.dim():map("\\D")
					Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("\\c")
					Snacks.toggle.option("cursorcolumn", { name = "Cursorcolumn" }):map("\\C")
					Snacks.toggle.option("ignorecase", { name = "Ignore Case" }):map("\\i")
					Snacks.toggle.option("list", { name = ":set list" }):map("\\l")
					Snacks.toggle.option("hlsearch", { name = "Search Highlight" }):map("\\h")
				end,
			})
		end,
	},
	{
		"folke/which-key.nvim",
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
				{ "]", group = "iteration" },
				{ "[", group = "reverse iteration" },
				{ "\\", group = "toggle" },
				{ "g", group = "goto/misc" },
				{ "z", group = "fold/spell/scroll" },
				{ "<Leader>", group = "Leader maps" },
				{ "<LocalLeader>", group = "Local leader" },
				{ "n", desc = "Next search result" },
				{ "N", desc = "Prev search result" },
				{ "p", desc = "Paste after" },
				{ "P", desc = "Paste before" },
				{ "u", desc = "Undo" },
				{ "S", desc = "Delete line & insert" },
				{ "C", desc = "Change to end of line" },
				{ "*", desc = "Search word forward" },
				{ "#", desc = "Search word backward" },
				{ "Y", desc = "Yank to end of line" },
				{ "&", desc = "Repeat last :s" },
				{ ".", desc = "Repeat last change" },
				{ "@", desc = "Execute macro" },
				{ "q", desc = "Record macro" },
				{ "Q", desc = "Replay last macro" },
				{ "U", desc = "Undo line" },
				{ "<C-r>", desc = "Redo" },
				{ "J", desc = "Join lines" },
				{
					"C-w",
					group = "windows",
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},
				{
					"<leader>b",
					group = "buffers",
					expand = function()
						return require("which-key.extras").expand.buf()
					end,
				},
			},
		},
	},
	{
		"folke/trouble.nvim",
		specs = {
			{
				"folke/edgy.nvim",
				optional = true,
				opts_extend = { "bottom", "left", "right" },
				---@type Edgy.Config
				opts = {
					bottom = {
						{
							title = "Diagnostics",
							ft = "trouble",
							filter = function(_, win)
								return vim.w[win].trouble
									and vim.w[win].trouble.position == "bottom"
									and vim.w[win].trouble.type == "split"
									and vim.w[win].trouble.relative == "editor"
									and vim.w[win].trouble.mode == "diagnostics"
									and not vim.w[win].trouble_preview
							end,
						},
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
						{ "<Leader>x", group = "trouble" },
					},
				},
			},
			{
				"ibhagwan/fzf-lua",
				dependencies = {
					"folke/trouble.nvim",
				},
				optional = true,
				opts = {
					actions = {
						files = {
							["ctrl-t"] = function()
								require("trouble.sources.fzf").actions.open()
							end,
						},
					},
				},
			},
		},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false win.position=left<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=left<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle win.position=bottom<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
		---@type trouble.Config
		opts = {
			open_no_results = true,
		},
	},
}
