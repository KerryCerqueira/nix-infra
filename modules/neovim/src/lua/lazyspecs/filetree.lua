---@type LazySpec
return {
	{
		"A7Lavinraj/fyler.nvim",
		dependencies = {
			"echasnovski/mini.icons",
		},
		lazy = false,
		cmd = "Fyler",
		keys = {
			{
				"<leader>-",
				function()
					local dir = vim.fn.expand("%:p:h")
					if dir == "" or vim.fn.isdirectory(dir) == 0 then
						dir = vim.fn.getcwd()
					end
					require("fyler").toggle({ dir = dir, kind = "float" })
				end,
				desc = "Explorer Fyler (file dir)",
			},
		},
		opts = {
			views = {
				finder = {
					close_on_select = true,
					default_explorer = true,
					follow_current_file = true,
					git_status = {
						enabled = true,
					},
					indentscope = {
						enabled = true,
						marker = "│",
					},
					mappings = {
						["q"] = "CloseView",
						["<CR>"] = "Select",
						["t"] = "SelectTab",
						["s"] = "SelectVSplit",
						["S"] = "SelectSplit",
						["-"] = "GotoParent",
						["C"] = "CollapseNode",
						["z"] = "CollapseAll",
						["="] = "GotoCwd",
						["."] = "GotoNode",
					},
					win = {
						border = "rounded",
						kind = "float",
						kinds = {
							float = {
								height = "80%",
								width = "85%",
								top = "7%",
								left = "7.5%",
							},
						},
					},
				},
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
					preferred_picker = "fzf-lua",
				},
			},
		},
	},
}
