---@type LazySpec
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"echasnovski/mini.icons",
		},
		specs = {
			"folke/edgy.nvim",
			optional = true,
			opts_extend = { "bottom", "left", "right" },
			---@type Edgy.Config
			opts = {
				left = {
					{
						title = "Neo-Tree Buffers",
						ft = "neo-tree",
						filter = function(buf)
							return vim.b[buf].neo_tree_source == "buffers"
						end,
						open = function()
							vim.cmd("Neotree show position=top buffers dir=%s", vim.fn.getcwd())
						end,
					},
				},
			},
		},
		cmd = "Neotree",
		keys = {
			{
				"<leader>-",
				function()
					local reveal_file = vim.fn.expand("%:p")
					if reveal_file == "" then
						reveal_file = vim.fn.getcwd()
					else
						local f = io.open(reveal_file, "r")
						if f then
							f.close(f)
						else
							reveal_file = vim.fn.getcwd()
						end
					end
					require("neo-tree.command").execute({
						action = "focus",
						toggle = true,
						source = "filesystem",
						position = "float",
						reveal_file = reveal_file,
						reveal_force_cwd = true,
					})
				end,
				desc = "Explorer NeoTree (root dir)",
			},
		},
		---@module 'neo-tree'
		---@type neotree.Config
		opts = {
			window = {
				popup = {
					size = {
						height = "80%",
						width = "85%",
					},
				},
			},
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"document_symbols",
			},
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_diagnostics = true,
			open_files_do_not_replace_types = {
				"terminal",
				"trouble",
				"Trouble",
				"Outline",
				"qf",
				"edgy",
			},
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				type = {
					enabled = true,
					required_width = 88, -- min width of window required to show this column
				},
				last_modified = {
					format = "relative",
					enabled = true,
					required_width = 64, -- min width of window required to show this column
				},
				created = {
					format = "relative",
					enabled = true,
					required_width = 88, -- min width of window required to show this column
				},
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				symlink_target = {
					enabled = true,
				},
			},
			filesystem = {
				hijack_netrw_behavior = "disabled",
				filtered_items = {
					visible = true,
					hide_dotfiles = true,
					hide_gitignored = true,
					always_show = { ".gitignore" },
				},
				follow_current_file = {
					enabled = true,
				},
				window = {
					mappings = {
						["-"] = "navigate_up",
					},
				},
			},
			buffers = {
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				group_empty_dirs = true,
				show_unloaded = true,
			},
		},
	},
	{
		"stevearc/oil.nvim",
		lazy = false,
		specs = {
			{
				"benomahony/oil-git.nvim",
				dependencies = { "stevearc/oil.nvim" },
			},
			{
				"JezerM/oil-lsp-diagnostics.nvim",
				dependencies = { "stevearc/oil.nvim" },
				opts = {},
			},
		},
		keys = {
			{
				"-",
				"<cmd>Oil --float<CR>",
				desc = "Explorer Oil",
			},
		},
		---@type oil.SetupOpts
		opts = {
			keymaps = {
				["?"] = { "actions.show_help", mode = "n" },
				["q"] = { "actions.close", mode = "n" },
				["<C-r>"] = "actions.refresh",
				["\\T"] = { "actions.toggle_trash", mode = "n" },
			},
		},
	},
	{
		"uhs-robert/sshfs.nvim",
		specs = {
			{
				"folke/which-key.nvim",
				optional = true,
				opts_extend = { "spec" },
				---@type wk.Opts
				opts = {
					spec = {
						{ "<leader>M", group = "sshfs mount" },
					},
				},
			},
		},
		opts = {
			connections = {
				ssh_configs = vim.list_extend({
					vim.fn.expand("$HOME" .. "/.ssh/config"),
					"/etc/ssh_config",
				}, vim.fn.globpath(vim.fn.expand("$HOME" .. "/.ssh/config.d"), "*", false, true)),
			},
			lead_prefix = "<leader>M",
			ui = {
				file_picker = {
					preferred_picker = "neo-tree",
				},
			},
		},
	},
}
