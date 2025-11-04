if false then
	require("lazy")
end

---@type LazySpec
return {
	"Owen-Dechow/videre.nvim",
	cmd = "Videre",
	keys = {
		{ "<leader>gv", "<cmd>Videre<cr>", desc = "Videre" },
	},
	dependencies = {
		"Owen-Dechow/graph_view_yaml_parser",
		"Owen-Dechow/graph_view_toml_parser",
		"a-usr/xml2lua.nvim",
	},
	opts = {
		round_units = false,
		simple_statusline = true,
		editor_type = "floating",
	}
}
