local function project_root(bufnr)
	bufnr = bufnr or 0
	return vim.fs.root(bufnr, { ".git", "flake.nix", "Makefile" }) or vim.fn.getcwd()
end

---@type LazySpec
return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-mini/mini.icons" },
		event = "VeryLazy",
		keys = {
			{
				"<c-j>",
				"<c-j>",
				ft = "fzf",
				mode = "t",
				nowait = true,
			},
			{
				"<c-k>",
				"<c-k>",
				ft = "fzf",
				mode = "t",
				nowait = true,
			},
			{
				"<leader>,",
				"<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
				desc = "Switch Buffer",
			},
			{
				"<leader>/",
				function()
					require("fzf-lua").live_grep({ cwd = project_root(0) })
				end,
				desc = "Grep (Root Dir)",
			},
			{
				"<leader>:",
				"<cmd>FzfLua command_history<cr>",
				desc = "Command History",
			},
			{
				"<leader><space>",
				function()
					require("fzf-lua").files({ cwd = project_root(0) })
				end,
				desc = "Find Files (Root Dir)",
			},
			{
				"<leader>fb",
				"<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
				desc = "Buffers",
			},
			{
				"<leader>fc",
				function()
					require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>ff",
				function()
					require("fzf-lua").files({ cwd = project_root(0) })
				end,
				desc = "Find Files (Root Dir)",
			},
			{
				"<leader>fF",
				function()
					require("fzf-lua").files({ cwd = vim.fn.getcwd() })
				end,
				desc = "Find Files (cwd)",
			},
			{
				"<leader>fr",
				"<cmd>FzfLua oldfiles<cr>",
				desc = "Recent",
			},
			{
				'<leader>s"',
				"<cmd>FzfLua registers<cr>",
				desc = "Registers",
			},
			{
				"<leader>sa",
				"<cmd>FzfLua autocmds<cr>",
				desc = "Auto Commands",
			},
			{
				"<leader>sb",
				"<cmd>FzfLua grep_curbuf<cr>",
				desc = "Buffer",
			},
			{
				"<leader>sc",
				"<cmd>FzfLua command_history<cr>",
				desc = "Command History",
			},
			{
				"<leader>sC",
				"<cmd>FzfLua commands<cr>",
				desc = "Commands",
			},
			{
				"<leader>sd",
				"<cmd>FzfLua diagnostics_document<cr>",
				desc = "Document Diagnostics",
			},
			{
				"<leader>sD",
				"<cmd>FzfLua diagnostics_workspace<cr>",
				desc = "Workspace Diagnostics",
			},
			{
				"<leader>sg",
				function()
					require("fzf-lua").live_grep({ cwd = project_root(0) })
				end,
				desc = "Grep (Root Dir)",
			},
			{
				"<leader>sG",
				function()
					require("fzf-lua").live_grep({ cwd = vim.fn.getcwd() })
				end,
				desc = "Grep (cwd)",
			},
			{
				"<leader>sh",
				"<cmd>FzfLua help_tags<cr>",
				desc = "Help Pages",
			},
			{
				"<leader>sH",
				"<cmd>FzfLua highlights<cr>",
				desc = "Search Highlight Groups",
			},
			{
				"<leader>sj",
				"<cmd>FzfLua jumps<cr>",
				desc = "Jumplist",
			},
			{
				"<leader>sk",
				"<cmd>FzfLua keymaps<cr>",
				desc = "Key Maps",
			},
			{
				"<leader>sl",
				"<cmd>FzfLua loclist<cr>",
				desc = "Location List",
			},
			{
				"<leader>sM",
				"<cmd>FzfLua man_pages<cr>",
				desc = "Man Pages",
			},
			{
				"<leader>sm",
				"<cmd>FzfLua marks<cr>",
				desc = "Jump to Mark",
			},
			{
				"<leader>sR",
				"<cmd>FzfLua resume<cr>",
				desc = "Resume",
			},
			{
				"<leader>sq",
				"<cmd>FzfLua quickfix<cr>",
				desc = "Quickfix List",
			},
			{
				"<leader>sw",
				function()
					require("fzf-lua").grep_cword({ cwd = project_root(0) })
				end,
				desc = "Word (Root Dir)",
			},
			{
				"<leader>sW",
				function()
					require("fzf-lua").grep_cword({ cwd = vim.fn.getcwd() })
				end,
				desc = "Word (cwd)",
			},
			{
				"<leader>sw",
				function()
					require("fzf-lua").grep_visual({ cwd = project_root(0) })
				end,
				mode = "v",
				desc = "Selection (Root Dir)",
			},
			{
				"<leader>sW",
				function()
					require("fzf-lua").grep_visual({ cwd = vim.fn.getcwd() })
				end,
				mode = "v",
				desc = "Selection (cwd)",
			},
			{
				"<leader>ss",
				function()
					require("fzf-lua").lsp_document_symbols()
				end,
				desc = "Goto Symbol",
			},
			{
				"<leader>sS",
				function()
					require("fzf-lua").lsp_live_workspace_symbols()
				end,
				desc = "Goto Symbol (Workspace)",
			},
		},
		opts = function()
			return
			---@module "fzf-lua"
			---@type fzf-lua.Config|{}
			---@diagnostic disable: missing-fields
			{
				"default-title",
				ui_select = true,
        actions = {
					files = {
						["enter"] = require("fzf-lua").actions.file_edit_or_qf,
						["ctrl-s"] = require("fzf-lua").actions.file_split,
						["ctrl-v"] = require("fzf-lua").actions.file_vsplit,
						["ctrl-t"] = require("fzf-lua").actions.file_tabedit,
						["alt-q"] = require("fzf-lua").actions.file_sel_to_qf,
						["alt-Q"] = require("fzf-lua").actions.file_sel_to_ll,
						["alt-i"] = require("fzf-lua").actions.toggle_ignore,
						["alt-h"] = require("fzf-lua").actions.toggle_hidden,
						["alt-f"] = require("fzf-lua").actions.toggle_follow,
					},
				},
				files = {
					cwd_prompt = false,
					follow = true,
				},
				fzf_colors = true,
				grep = {
					follow = true,
				},
				keymap = {
					fzf = {
						true,
						["ctrl-q"] = "select-all+accept",
						["ctrl-u"] = "half-page-up",
						["ctrl-d"] = "half-page-down",
						["ctrl-x"] = "jump",
						["ctrl-f"] = "preview-page-down",
						["ctrl-b"] = "preview-page-up",
					},
					builtin = {
						true,
						["<c-f>"] = "preview-page-down",
						["<c-b>"] = "preview-page-up",
					},
				},
				lsp = {
					symbols = {
						symbol_hl = function(s)
							return "TroubleIcon" .. s
						end,
						symbol_fmt = function(s)
							return s:lower() .. "\t"
						end,
						child_prefix = false,
					},
					code_actions = {
						previewer = "codeaction_native",
					},
				},
				winopts = {
					width = 0.8,
					height = 0.8,
					row = 0.5,
					col = 0.5,
				},
			}
		end,
	},
	{
		"folke/which-key.nvim",
		optional = true,
		opts_extend = { "spec" },
		---@type wk.Opts
		opts = {
			spec = {
				{ "<leader>f", group = "find" },
				{ "<leader>s", group = "search" },
			},
		},
	},
}
