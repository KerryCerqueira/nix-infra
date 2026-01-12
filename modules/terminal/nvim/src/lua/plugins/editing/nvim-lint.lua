return {
	"mfussenegger/nvim-lint",
	config = function(_, opts)
		require("lint").linters_by_ft = opts.linters_by_ft or {}
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end
}
