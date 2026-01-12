return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"AndreM222/copilot-lualine",
		"arkav/lualine-lsp-progress",
	},
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			-- set an empty statusline till lualine loads
			vim.o.statusline = " "
		else
			-- hide the statusline on the starter page
			vim.o.laststatus = 0
		end
	end,
	opts = {
		options = {
			section_separators = { left = '', right = '' },
			component_separators = { left = '', right = '' },
			theme = "auto",
			globalstatus = true,
			disabled_filetypes = {
				statusline = { "dashboard", "alpha", "starter" },
				winbar = { "neominimap", "trouble", "neo-tree"},
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", },

			lualine_c = {
				{
					"diagnostics",
					symbols = {
						error = " ",
						warn = " ",
						info = " ",
						hint = " ",
					},
				},
			},
			lualine_x = {
				"lsp_progress",
				"copilot",
				{
					"diff",
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
					},
					source = function()
						local gitsigns = vim.b.gitsigns_status_dict
						if gitsigns then
							return {
								added = gitsigns.added,
								modified = gitsigns.changed,
								removed = gitsigns.removed,
							}
						end
					end,
				},
			},
			lualine_y = {
				{ "progress", separator = " ",                  padding = { left = 1, right = 0 } },
				{ "location", padding = { left = 0, right = 1 } },
			},
			lualine_z = {
				function()
					return " " .. os.date("%R")
				end,
			},
		},
		winbar = {
			lualine_a = {
				"filename",
			},
			lualine_y = {
				{ "filetype", separator = "", },
				{ "filesize", separator = "", }, "encoding",
			},
		},
		inactive_winbar = {
			lualine_b = {
				"filename",
			},
			lualine_x = {
				{ "filetype", separator = "", },
				{ "filesize", separator = "", }, "encoding",
			},
		},
		extensions = { "lazy", "quickfix", "trouble", "fzf" },
	}
}
