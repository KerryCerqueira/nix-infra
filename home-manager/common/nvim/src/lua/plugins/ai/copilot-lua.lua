if false then
	require("lazy")
	require("blink.cmp")
end

---@type LazySpec
return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		cmd = "Copilot",
		opts = {
			panel = {
				enabled = false,
			},
		},
	},
}
