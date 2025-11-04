return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"folke/snacks.nvim",
		},
		lazy = false,
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
			{ -- buffers
				"<leader>cb",
				function()
					require("neo-tree.command").execute({
						action = "focus",
						source = "buffers",
						-- position = "float",
					})
				end,
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
		-- This should work but doesn't.
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "neo-tree-preview",
				callback = function()
					vim.opt_local.foldmethod = "manual"
				end,
			})
		end,
	},
	{
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
}
