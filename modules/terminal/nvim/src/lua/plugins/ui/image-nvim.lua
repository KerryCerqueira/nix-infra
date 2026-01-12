return {
	"3rd/image.nvim",
	event = {
		"BufReadPre *.png",
		"BufReadPre *.jpg",
		"BufReadPre *.jpeg",
		"BufReadPre *.gif",
		"BufReadPre *.webp",
		"BufReadPre *.avif"
	},
	ft = { "markdown", "vimwiki", "norg" },
	opts = {}
}
