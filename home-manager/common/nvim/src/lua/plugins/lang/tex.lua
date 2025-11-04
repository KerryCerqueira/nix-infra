if false then
	require("lazy")
	require("which-key")
end

---@type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
			end
			if type(opts.highlight) == "table" then
				if type(opts.highlight.disable) == "table" then
					vim.list_extend(opts.highlight.disable, { "latex" })
				else
					opts.highlight.disable = { "latex" }
				end
			else
				opts.highlight = { disable = "latex" }
			end
		end,
	},
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.api.nvim_create_autocmd({ "FileType" }, {
				group = vim.api.nvim_create_augroup(
					"lazyvim_vimtex_conceal",
					{ clear = true }
				),
				pattern = { "bib", "tex" },
				callback = function()
					vim.wo.conceallevel = 2
				end,
			})
		end,
		config = function()
			vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
			vim.g.vimtex_quickfix_method = (
				vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
			)
			vim.g.vimtex_view_method = "zathura"
		end,
	},
	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				tex = { "chktex" },
			},
		},
	},
	{
		"folke/which-key.nvim",
		opts_extend = { "spec" },
		optional = true,
		---@type wk.Opts
		opts = {
			spec = {
				{ "<localleader>l", group = "vimtex" },
			},
		},
	},
}
