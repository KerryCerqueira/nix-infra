if false then
	require("lazy")
	require("which-key")
	require("edgy")
end

---@type LazySpec
return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.laststatus = 3
		vim.opt.splitkeep = "screen"
	end,
	opts_extend = { "bottom", "left", "right" },
	---@type Edgy.Config
	opts = {
		bottom = {
			{ ft = "qf", title = "QuickFix" },
			{
				ft = "markdown",
				size = { height = 12 },
				-- only show help buffers
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
			{
				ft = "text",
				size = { height = 12 },
				-- only show help buffers
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
			{
				ft = "help",
				size = { height = 12 },
				-- only show help buffers
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
		},
		exit_when_last = true,
	},
}
