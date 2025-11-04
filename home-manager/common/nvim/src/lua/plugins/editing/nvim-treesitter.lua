if false then
	require("lazy")
	require("which-key")
end

---@type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		specs = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				event = { "BufReadPre", "BufNewFile" },
				dependencies = { "nvim-treesitter/nvim-treesitter" },
			},
			{
				"RRethy/nvim-treesitter-endwise",
				event = { "BufReadPre", "BufNewFile" },
				dependencies = { "nvim-treesitter/nvim-treesitter" },
			},
			{
				"nvim-treesitter/nvim-treesitter-context",
				dependencies = { "nvim-treesitter/nvim-treesitter" },
				opts = { mode = "cursor", max_lines = 3 },
				keys = {
					{
						"\\tc",
						function()
							require("treesitter-context").toggle()
							vim.notify("Toggle treesitter context.")
						end,
						desc = "Toggle Treesitter Context",
					},
				},
			},
		},
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		opts = {
			ensure_installed = {
				"html",
				"bash",
				"csv",
				"diff",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"json",
				"latex",
				"markdown",
				"markdown_inline",
				"regex",
				"ssh_config",
				"toml",
				"tsv",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			endwise = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-Space>",
					scope_incremental = "<TAB>",
					node_incremental = "<C-Space>",
					node_decremental = "<Space>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "treesitter function" },
						["if"] = { query = "@function.inner", desc = "treesitter function" },
						["ac"] = { query = "@class.outer", desc = "treesitter class" },
						["ic"] = { query = "@class.inner", desc = "treesitter class" },
						["iS"] = { query = "@local.scope", query_group = "locals", desc = "language scope" },
						["aS"] = { query = "@local.scope", query_group = "locals", desc = "language scope" },
						["iP"] = { query = "@parameter.inner", desc = "treesitter parameter" },
						["aP"] = { query = "@parameter.outer", desc = "treesitter parameter" },
					},
					selection_modes = {
						["@function.outer"] = "V",
						["@class.outer"] = "V",
					},
				},
			},
		},
		init = function()
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.treesitter.language.register("bash", "kitty")
			vim.filetype.add({
				extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
				filename = {
					["vifmrc"] = "vim",
				},
				pattern = {
					[".*/waybar/config"] = "jsonc",
					[".*/kitty/.+%.conf"] = "kitty",
					[".*/hypr/.+%.conf"] = "hyprlang",
					["%.env%.[%w_.-]+"] = "sh",
				},
			})
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"folke/which-key.nvim",
		optional = true,
		opts_extend = { "spec" },
		---@type wk.Opts
		opts = {
			spec = {
				{ "\\t", group = "treesitter" },
			},
		},
	},
}
