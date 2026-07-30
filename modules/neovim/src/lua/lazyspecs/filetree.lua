---@type LazySpec
return {
	{
		"FylerOrg/fyler.nvim",
		dependencies = {
			"echasnovski/mini.icons",
		},
		lazy = false,
		cmd = "Fyler",
		keys = {
			{
				"<leader>-",
				function()
					local root = vim.fs.root(0, { ".git", "flake.nix", ".luarc.json" }) or vim.fn.getcwd()
					require("fyler").toggle({ root_path = root, kind = "floating" })
				end,
				desc = "Explorer Fyler (project root)",
			},
		},
		opts = {
			kind = "floating",
			use_as_default_explorer = true,
			follow_current_file = true,
			follow_root_dir = false,
			integrations = {
				icon = "mini_icons",
			},
			extensions = {
				git = { enabled = true },
			},
			ui = {
				indent_guides = true,
			},
			kind_presets = {
				floating = {
					height = "80%",
					width = "85%",
					col = "center",
					row = "center",
				},
			},
			mappings = {
				n = {
					["q"] = { action = "close" },
					["<CR>"] = { action = "select", args = { close = true, pick = false } },
					["t"] = { action = "select", args = { tabedit = true, close = true } },
					["s"] = { action = "select", args = { vsplit = true, close = true } },
					["S"] = { action = "select", args = { split = true, close = true } },
					["-"] = { action = "visit", args = { parent = true } },
					["C"] = { action = "shrink" },
					["="] = { action = "visit" },
					["."] = { action = "visit", args = { cursor = true } },
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
