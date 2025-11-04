if false then
	require("lazy")
	require("snacks")
	require("which-key")
end

local function project_root(bufnr)
	bufnr = bufnr or 0
	-- 1) LSP root
	for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		local r = c.config and c.config.root_dir
		---@diagnostic disable-next-line: undefined-field
		if r and vim.uv.fs_stat(r) then return r end
	end
	-- 2) git toplevel
	local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
	local cmd = ("git -C %s rev-parse --show-toplevel"):format(vim.fn.shellescape(dir or vim.fn.getcwd()))
	local out = vim.fn.systemlist(cmd)[1]
	if out and out ~= "" then return out end
	-- 3) fallback
	return vim.fn.getcwd()
end

---@type LazySpec
return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-mini/mini.icons" },
		keys = {
			{
				"<c-j>",
				"<c-j>",
				ft = "fzf",
				mode = "t",
				nowait = true
			},
			{
				"<c-k>",
				"<c-k>",
				ft = "fzf",
				mode = "t",
				nowait = true
			},
			{
				"<leader>,",
				"<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
				desc = "Switch Buffer",
			},
			{
				"<leader>/",
				function() require("fzf-lua").live_grep({ cwd = project_root(0) }) end,
				desc = "Grep (Root Dir)"
			},
			{
				"<leader>:",
				"<cmd>FzfLua command_history<cr>",
				desc = "Command History"
			},
			{
				"<leader><space>",
				function() require("fzf-lua").files({ cwd = project_root(0) }) end,
				desc = "Find Files (Root Dir)"
			},
			{
				"<leader>fb",
				"<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
				desc = "Buffers"
			},
			{
				"<leader>fc",
				function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end,
				desc = "Find Config File"
			},
			{
				"<leader>ff",
				function() require("fzf-lua").files({ cwd = project_root(0) }) end,
				desc = "Find Files (Root Dir)"
			},
			{
				"<leader>fF",
				function() require("fzf-lua").files({ cwd = vim.fn.getcwd() }) end,
				desc = "Find Files (cwd)"
			},
			{
				"<leader>fg",
				"<cmd>FzfLua git_files<cr>",
				desc = "Find Files (git-files)"
			},
			{
				"<leader>fr",
				"<cmd>FzfLua oldfiles<cr>",
				desc = "Recent"
			},
			-- git
			{
				"<leader>gc",
				"<cmd>FzfLua git_commits<CR>",
				desc = "Commits"
			},
			{
				"<leader>gs",
				"<cmd>FzfLua git_status<CR>",
				desc = "Status"
			},
			{
				'<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers"
			},
			{
				"<leader>sa",
				"<cmd>FzfLua autocmds<cr>",
				desc = "Auto Commands"
			},
			{
				"<leader>sb",
				"<cmd>FzfLua grep_curbuf<cr>",
				desc = "Buffer"
			},
			{
				"<leader>sc",
				"<cmd>FzfLua command_history<cr>",
				desc = "Command History"
			},
			{
				"<leader>sC",
				"<cmd>FzfLua commands<cr>",
				desc = "Commands"
			},
			{
				"<leader>sd",
				"<cmd>FzfLua diagnostics_document<cr>",
				desc = "Document Diagnostics"
			},
			{
				"<leader>sD",
				"<cmd>FzfLua diagnostics_workspace<cr>",
				desc = "Workspace Diagnostics"
			},
			{
				"<leader>sg",
				function() require("fzf-lua").live_grep({ cwd = project_root(0) }) end,
				desc = "Grep (Root Dir)"
			},
			{
				"<leader>sG",
				function() require("fzf-lua").live_grep({ cwd = vim.fn.getcwd() }) end,
				desc = "Grep (cwd)"
			},
			{
				"<leader>sh",
				"<cmd>FzfLua help_tags<cr>",
				desc = "Help Pages"
			},
			{
				"<leader>sH",
				"<cmd>FzfLua highlights<cr>",
				desc = "Search Highlight Groups"
			},
			{
				"<leader>sj",
				"<cmd>FzfLua jumps<cr>",
				desc = "Jumplist"
			},
			{
				"<leader>sk",
				"<cmd>FzfLua keymaps<cr>",
				desc = "Key Maps"
			},
			{
				"<leader>sl",
				"<cmd>FzfLua loclist<cr>",
				desc = "Location List"
			},
			{
				"<leader>sM",
				"<cmd>FzfLua man_pages<cr>",
				desc = "Man Pages"
			},
			{
				"<leader>sm",
				"<cmd>FzfLua marks<cr>",
				desc = "Jump to Mark"
			},
			{
				"<leader>sR",
				"<cmd>FzfLua resume<cr>",
				desc = "Resume"
			},
			{
				"<leader>sq",
				"<cmd>FzfLua quickfix<cr>",
				desc = "Quickfix List"
			},
			{
				"<leader>sw",
				function() require("fzf-lua").grep_cword({ cwd = project_root(0) }) end,
				desc = "Word (Root Dir)"
			},
			{
				"<leader>sW",
				function() require("fzf-lua").grep_cword({ cwd = vim.fn.getcwd() }) end,
				desc = "Word (cwd)"
			},
			{
				"<leader>sw",
				function() require("fzf-lua").grep_visual({ cwd = project_root(0) }) end,
				mode = "v",
				desc = "Selection (Root Dir)"
			},
			{
				"<leader>sW",
				function() require("fzf-lua").grep_visual({ cwd = vim.fn.getcwd() }) end,
				mode = "v",
				desc = "Selection (cwd)"
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
			fzflua = require("fzf-lua")
			return {
				"default-title",
				actions = {
					files = {
						["enter"]       = fzflua.actions.file_edit_or_qf,
						["ctrl-s"]      = fzflua.actions.file_split,
						["ctrl-v"]      = fzflua.actions.file_vsplit,
						["ctrl-t"]      = fzflua.actions.file_tabedit,
						["alt-q"]       = fzflua.actions.file_sel_to_qf,
						["alt-Q"]       = fzflua.actions.file_sel_to_ll,
						["alt-i"]       = fzflua.actions.toggle_ignore,
						["alt-h"]       = fzflua.actions.toggle_hidden,
						["alt-f"]       = fzflua.actions.toggle_follow,
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
						previewer = "codeaction_native"
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
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "fzf-lua" } })
				require("fzf-lua").register_ui_select(function(fzf_opts, items)
					-- Base: prompt + centered title derived from prompt text
					local base = {
						prompt = " ",
						winopts = {
							title = (" %s "):format(
								vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", ""))
							),
							title_pos = "center",
						},
					}
					local overlay
					if fzf_opts.kind == "codeaction" then
						overlay = {
							winopts = {
								layout = "vertical",
								width = 0.5,
								height = math.floor(
									math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5
								) + 16,
								preview = {
									layout = "vertical",
									vertical = "down:15,border-top",
									hidden = #vim.lsp.get_clients({ bufnr = 0, name = "vtsls" }) > 0,
								},
							},
						}
					else
						overlay = {
							winopts = {
								width  = 0.5,
								height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
							},
						}
					end
					return vim.tbl_deep_extend("force", fzf_opts, base, overlay)
				end
				)
				return vim.ui.select(...)
			end
		end
	},
	{
		"folke/snacks.nvim",
		optional = true,
		---@type snacks.Config
		opts = {
			image = { enabled = true },
		},
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
