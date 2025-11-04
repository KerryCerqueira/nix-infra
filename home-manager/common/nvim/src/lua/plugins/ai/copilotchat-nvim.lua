return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-treesitter/nvim-treesitter" },
	},
	cmd = {
		"CopilotChat",
		"CopilotChatOpen",
		"CopilotChatToggle",
		"CopilotChatLoad",
		"CopilotChatPrompts",
		"CopilotChatModels",
	},
	event = { "InsertEnter", "CmdlineEnter" },
	opts = function()
		local user = vim.env.USER or "User"
		user = user:sub(1, 1):upper() .. user:sub(2)
		return {
			auto_insert_mode = true,
			question_header = "  " .. user .. " ",
			answer_header = "  Copilot ",
			window = {
				width = 0.4,
			},
		}
	end,
}
