if false then
	require("lazy")
	require("obsidian")
end

---@type LazySpec
return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	ft = "markdown",
	---@type obsidian.config
	opts = {
		legacy_commands = false,
	},
}
