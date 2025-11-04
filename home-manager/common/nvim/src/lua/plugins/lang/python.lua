if false then
	require("lazy")
end

---@type LazySpec
return {
	{
		"danymat/neogen",
		opts = {
			languages = {
				python = {
					template = {
						annotation_convention = "reST",
					},
				},
			},
		},
	},
}
