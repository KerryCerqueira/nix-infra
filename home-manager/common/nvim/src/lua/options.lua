return {
	setup = function()
		vim.g.mapleader = " "
		vim.g.maplocalleader = ","
		vim.opt.number = true
		vim.opt.mouse = "a"
		vim.opt.showmode = false
		vim.opt.breakindent = true
		vim.opt.undofile = true
		vim.opt.ignorecase = true
		vim.opt.smartcase = true
		vim.opt.signcolumn = "yes"
		vim.opt.updatetime = 800
		vim.opt.timeoutlen = 300
		vim.opt.splitright = true
		vim.opt.splitbelow = true
		vim.opt.cursorline = true
		vim.opt.scrolloff = 10
		vim.opt.confirm = true
		vim.lsp.enable({
			"bashls",
			"fish_lsp",
			"hypr_ls",
			"jsonls",
			"lua_ls",
			"markdown_oxide",
			"marksman",
			"nil_ls",
			"pyright",
			"ruff",
			"taplo",
			"texlab",
			"yamlls",
		})
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = false,
				severity_sort = true,
			},
		})
	end,
}
