---@type LazySpec
return {
	{
		"danilamihailov/beacon.nvim",
		opts = {},
		event = {
			"CursorMoved",
			"WinEnter",
			"FocusGained",
		},
	},
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		---@type CatppuccinOptions
		opts = {
			transparent_background = true,
			term_colors = true,
			auto_integrations = true,
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		event = { "WinLeave" },
		opts = {},
	},
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		keys = {
			{
				"\\e",
				function()
					require("edgy").toggle()
				end,
				desc = "Edgy Toggle",
			},
			{
				"<leader>fe",
				function()
					require("edgy").select()
				end,
				desc = "Edgy Select Window",
			},
		},
		opts_extend = { "bottom", "left", "right" },
		---@type Edgy.Config
		opts = {
			bottom = {
				{ ft = "qf", title = "QuickFix" },
				{
					ft = "markdown",
          title = "Help",
					size = { height = 20 },
					-- only show help buffers
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
				{
					ft = "text",
          title = "Help",
					size = { height = 20 },
					-- only show help buffers
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
				{
					ft = "help",
          title = "Help",
					size = { height = 20 },
					-- only show help buffers
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
			},
			exit_when_last = true,
		},
	},
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"Isrothy/neominimap.nvim",
		lazy = false,
		version = "v3.x.x",
		specs = {
			"folke/which-key.nvim",
			optional = true,
			opts_extend = { "spec" },
			---@type wk.Opts
			opts = {
				spec = {
					{ "\\m", group = "minimap" },
				},
			},
		},
		keys = {
			{ "\\mm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
			{ "\\mw", "<cmd>Neominimap WinToggle<cr>", desc = "Toggle minimap for current window" },
			{ "\\mt", "<cmd>Neominimap TabToggle<cr>", desc = "Toggle minimap for current tab" },
			{ "\\mb", "<cmd>Neominimap BufToggle<cr>", desc = "Toggle minimap for current buffer" },
			{ "\\mf", "<cmd>Neominimap ToggleFocus<cr>", desc = "Switch focus on minimap" },
		},
		init = function()
			---@type Neominimap.UserConfig
			vim.g.neominimap = {
				layout = "float",
				float = {
					window_border = "rounded",
				},
				auto_enable = true,
				close_if_last_window = true,
				exclude_filetypes = {
					"help",
					"qf",
					"bigfile",
					"trouble",
					"neo-tree",
					"neominimap",
					"NeogitStatus",
					"netrw",
				},
				exclude_buftypes = {
					"nofile",
					"nowrite",
					"quickfix",
					"terminal",
					"prompt",
				},
				tab_filter = function(tab_id)
					local win_list = vim.api.nvim_tabpage_list_wins(tab_id)
					local exclude_ft = {
						"help",
						"qf",
						"bigfile",
						"trouble",
						"neo-tree",
						"neominimap",
						"NeogitStatus",
						"netrw",
					}
					local function is_float_window(win_id)
						local win_config = vim.api.nvim_win_get_config(win_id)
						return win_config.relative ~= ""
					end
					for _, win_id in ipairs(win_list) do
						if not is_float_window(win_id) then
							local bufnr = vim.api.nvim_win_get_buf(win_id)
							if not vim.tbl_contains(exclude_ft, vim.bo[bufnr].filetype) then
								return true
							end
						end
					end
					return false
				end,
			}
		end,
	},
	{
		"rachartier/tiny-glimmer.nvim",
		event = "VeryLazy",
		priority = 10,
		opts = {
			enabled = true,
			disable_warnings = true,
			overwrite = {
				auto_map = true,
				search = { enabled = true },
				paste = { enabled = true },
				undo = { enabled = true },
				redo = { enabled = true },
				presets = { pulsar = { enabled = true } },
			},
		},
	},
	{
		"mcauley-penney/visual-whitespace.nvim",
		event = "ModeChanged *:[vV\22]",
		opts = {
			list_chars = {
				space = "·",
				tab = "→",
				nbsp = "␣",
			},
			match_types = {
				space = true,
				tab = true,
				nbsp = true,
			},
		},
	},
}
