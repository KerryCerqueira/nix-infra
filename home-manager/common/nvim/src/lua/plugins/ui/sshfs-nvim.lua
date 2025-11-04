if false then
	require("lazy")
end

---@type LazySpec
return {
	"uhs-robert/sshfs.nvim",
	opts = {
		connections = {
			ssh_configs = vim.list_extend(
				{
					vim.fn.expand("$HOME" .. "/.ssh/config"),
					"/etc/ssh_config",
				},
				vim.fn.globpath(
					vim.fn.expand("$HOME" .. "/.ssh/config.d"),
					"*",
					false,
					true
				)
			)
		},
		lead_prefix = "<leader>M",
		ui = {
			file_picker = {
				preferred_picker = "neo-tree",
			},
		},
	},
}
