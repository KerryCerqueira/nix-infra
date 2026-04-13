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
		vim.opt.list = true
		vim.opt.listchars = "tab:> ,trail:·,extends:…,precedes:…,nbsp:␣"
		vim.opt.pumblend = 10
		vim.opt.pumheight = 10
    vim.opt.winborder = "rounded"
		-- vim.lsp.enable({
		-- 	"bashls",
		-- 	"fish_lsp",
		-- 	"jsonls",
		-- 	"lua_ls",
		-- 	"markdown_oxide",
		-- 	"marksman",
		-- 	"nil_ls",
		-- 	"pyright",
		-- 	"ruff",
		-- 	"taplo",
		-- 	"texlab",
		-- 	"yamlls",
		-- })
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
		vim.filetype.add({
			extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
			filename = {
				["vifmrc"] = "vim",
			},
			pattern = {
				[".*/waybar/config"] = "jsonc",
				[".*/kitty/.+%.conf"] = "kitty",
				["%.env%.[%w_.-]+"] = "sh",
			},
		})
		vim.treesitter.language.register("bash", "kitty")
		vim.opt.cmdheight = 0
		require("vim._core.ui2").enable({
			enable = true,
			msg = {
				targets = {
					[""] = "msg",
					empty = "cmd",
					bufwrite = "msg",
					confirm = "cmd",
					emsg = "msg",
					echo = "msg",
					echomsg = "msg",
					echoerr = "msg",
					completion = "cmd",
					list_cmd = "pager",
					lua_error = "pager",
					lua_print = "msg",
					progress = "cmd",
					rpc_error = "pager",
					quickfix = "msg",
					search_cmd = "cmd",
					search_count = "cmd",
					shell_cmd = "pager",
					shell_err = "pager",
					shell_out = "pager",
					shell_ret = "msg",
					undo = "msg",
					verbose = "pager",
					wildlist = "cmd",
					wmsg = "msg",
					typed_cmd = "cmd",
				},
				cmd = {
					height = 0.5,
				},
				dialog = {
					height = 0.5,
				},
				msg = {
					height = 0.4,
					timeout = 5000,
				},
				pager = {
					height = 0.5,
				},
			},
		})
	end,
}
