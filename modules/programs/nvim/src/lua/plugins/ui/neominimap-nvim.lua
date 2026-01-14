if false then
	require("lazy")
	require("which-key")
	require("neominimap.config.meta")
end

---@type LazySpec
return {
	{
		"Isrothy/neominimap.nvim",
		lazy = false,
		keys = {
			{ "\\mm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
			{ "\\mw", "<cmd>Neominimap WinToggle<cr>", desc = "Toggle minimap for current window" },
			{ "\\mt", "<cmd>Neominimap TabToggle<cr>", desc = "Toggle minimap for current tab" },
			{ "\\mb", "<cmd>Neominimap BufToggle<cr>", desc = "Toggle minimap for current buffer" },
			{ "<leader>mf", "<cmd>Neominimap ToggleFocus<cr>", desc = "Switch focus on minimap" },
		},
		init = function()
			---@type Neominimap.UserConfig
			vim.g.neominimap = {
				layout = "float",
				float = {
					window_border = "rounded",
				},
				auto_enable = true,
				close_if_last_window = true,
				exclude_filetypes = {
					"help",
					"qf",
					"bigfile",
					"trouble",
					"neo-tree",
					"neominimap",
					"NeogitStatus",
					"netrw",
				},
				exclude_buftypes = {
					"nofile",
					"nowrite",
					"quickfix",
					"terminal",
					"prompt",
				},
				tab_filter = function(tab_id)
					local win_list = vim.api.nvim_tabpage_list_wins(tab_id)
					local exclude_ft = {
						"help",
						"qf",
						"bigfile",
						"trouble",
						"neo-tree",
						"neominimap",
						"NeogitStatus",
						"netrw",
					}
					local function is_float_window(win_id)
						local win_config = vim.api.nvim_win_get_config(win_id)
						return win_config.relative ~= ""
					end
					for _, win_id in ipairs(win_list) do
						if not is_float_window(win_id) then
							local bufnr = vim.api.nvim_win_get_buf(win_id)
							if not vim.tbl_contains(exclude_ft, vim.bo[bufnr].filetype) then
								return true
							end
						end
					end
					return false
				end,
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
				{ "\\m", group = "minimap" },
				{ "<leader>m", group = "minimap" },
			},
		},
	},
}
