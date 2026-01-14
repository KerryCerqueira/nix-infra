if false then
	require("lazy")
	require("which-key")
	require("edgy")
end
local user = vim.env.USER or "User"
user = user:sub(1, 1):upper() .. user:sub(2)

---@type LazySpec
return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"ravitemer/codecompanion-history.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"Davidyz/VectorCode",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		cmd = {
			"CodeCompanion",
			"CodeCompanionChat",
			"CodeCompanionCmd",
			"CodeCompanionActions",
			"CodeCompanionHistory",
			"CodeCompanionSummaries",
		},
		keys = {
			{
				"<Leader>ac",
				"<cmd>CodeCompanionChat Toggle<cr>",
				desc = "Open AI chat",
			},
			{
				"<Leader>ah",
				"<cmd>CodeCompanionHistory<cr>",
				desc = "Open AI chat history",
			},
			{
				"ga",
				"<cmd>CodeCompanionChat Add<cr>",
				mode = "v",
				desc = "Add visual selection to AI chat",
			},
			{
				"<C-a>",
				"<cmd>CodeCompanionActions<cr>",
				desc = "Open AI actions",
			},
		},
		init = function()
			vim.cmd([[cab cc CodeCompanion]])
		end,
		opts = {
			display = {
				chat = {
					window = {
						opts = {
							number = false,
							relativenumber = false,
						},
					},
				},
			},
			strategies = {
				chat = {
					keymaps = {
						stop = {
							modes = {
								n = "<C-c>",
								i = "<C-c>",
							},
							description = "Cancel request",
						},
					},
					roles = {
						llm = function(adapter)
							return "  (" .. adapter.formatted_name .. ")"
						end,
						user = "  " .. user,
					},
				},
			},
			extensions = {
				history = {
					enabled = true,
					opts = {
						keymap = "<Leader>ah",
						save_chat_keymap = "<Leader>as",
						auto_save = true,
						expiration_days = 0,
						picker = "telescope",
						auto_generate_title = true,
						title_generation_opts = {
							adapter = nil,
							model = nil,
						},
						continue_last_chat = false,
						delete_on_clearing_chat = false,
						dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
						enable_logging = false,
					},
				},
				vectorcode = {
					opts = {
						add_tool = true,
					},
				},
			},
		},
	},
	{
		"folke/which-key.nvim",
		optional = true,
		opts_extend = { "spec" },
		---@type wk.Opts
		opts = {
			spec = {
				{ "<leader>a", group = "ai" },
			},
		},
	},
	{
		"folke/edgy.nvim",
		optional = true,
		opts_extend = { "bottom", "left", "right" },
		---@type Edgy.Config
		opts = {
			right = {
				{
					ft = "codecompanion",
					title = "AI chat",
					size = { width = 70 },
					filter = function(_, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
			},
		},
	},
}
