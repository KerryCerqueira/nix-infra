return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async", },
	event = "BufEnter",
	keys = {
		{
			"zR",
			function()
				require("ufo").openAllFolds()
			end,
			desc = "Open all folds"
		},
		{
			"]z",
			function()
				require("ufo").goNextClosedFold()
			end,
			desc = "Next closed fold",
		},
		{
			"[z",
			function()
				require("ufo").goPreviousClosedFold()
			end,
			desc = "Previous closed fold",
		},
		{
			"zM",
			function()
				require("ufo").closeAllFolds()
			end,
			desc = "Close all folds"
		},
		{
			"K",
			function()
				local winid = require('ufo').peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end,
			desc = "LSP hover/fold peek",
		},
	},
	init = function()
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.o.updatetime = 800
	end,
	opts = {
		preview = {
			win_config = {
				winhighlight = 'Normal:Folded',
				winblend = 0
			},
			mappings = {
				scrollU = '<C-u>',
				scrollD = '<C-d>',
			}
		},
		provider_selector = function(bufnr, filetype, buftype)
			return {'treesitter', 'indent'}
		end,
		fold_virt_text_handler = function(
			virtText,
			lnum,
			endLnum,
			width,
			truncate
		)
			local newVirtText = {}
			local suffix = (' 󰁂 %d '):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, {chunkText, hlGroup})
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, {suffix, 'MoreMsg'})
			return newVirtText
		end
	},
}
