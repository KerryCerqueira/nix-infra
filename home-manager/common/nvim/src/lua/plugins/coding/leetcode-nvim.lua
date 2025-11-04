if false then
	require("lazy")
	require("leetcode")
end

---@type LazySpec
return {
	"kawre/leetcode.nvim",
	cmd = {
		"Leet",
		"Leet menu",
	},
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	---@type lc.Config
	opts = {
		lang = "python",
	},
}
