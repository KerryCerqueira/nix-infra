local md_ft = {
	"markdown",
	"quarto",
	"qmd",
	"rmarkdown",
	"pandoc",
	"markdown.pandoc",
}
---@type LazySpec
return {
	{
		"nvim-treesitter/nvim-treesitter",
		specs = {
			"folke/which-key.nvim",
			optional = true,
			opts_extend = { "spec" },
			---@type wk.Opts
			opts = {
				spec = {
					{ "\\t", group = "treesitter" },
				},
			},
		},
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		init = function()
			local ts_disabled = {
				tex = true,
				latex = true,
				plaintex = true,
			}
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local ft = vim.bo[ev.buf].filetype
					if not ts_disabled[ft] and pcall(vim.treesitter.start, ev.buf) then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = { mode = "cursor", max_lines = 3 },
		keys = {
			{
				"\\tc",
				function()
					require("treesitter-context").toggle()
					vim.notify("Toggle treesitter context.")
				end,
				desc = "Toggle Treesitter Context",
			},
		},
	},
	{
		"RRethy/nvim-treesitter-endwise",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"MeanderingProgrammer/treesitter-modules.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		---@module 'treesitter-modules'
		---@type ts.mod.UserConfig
		opts = {
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Tab>",
					node_incremental = "<Tab>",
					scope_incremental = "<S-Tab>",
					node_decremental = "<BS>",
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
    --stylua: ignore
		keys = {
			{
				"af",
				function()
					require("nvim-treesitter-textobjects.select")
            .select_textobject("@function.outer", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "TS function (outer)",
			},
			{
				"if",
				function()
					require("nvim-treesitter-textobjects.select")
            .select_textobject("@function.inner", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "TS function (inner)",
			},
			{
				"ac",
				function()
					require("nvim-treesitter-textobjects.select")
            .select_textobject("@class.outer", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "TS class (outer)",
			},
			{
				"ic",
				function()
					require("nvim-treesitter-textobjects.select")
            .select_textobject("@class.inner", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "TS class (inner)",
			},
			{
				"aP",
				function()
					require("nvim-treesitter-textobjects.select")
            .select_textobject("@parameter.outer", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "TS parameter (outer)",
			},
			{
				"iP",
				function()
					require("nvim-treesitter-textobjects.select")
            .select_textobject("@parameter.inner", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "TS parameter (inner)",
			},
			{
				"]f",
				function()
					require("nvim-treesitter-textobjects.move")
            .goto_next("@function.outer", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Next function",
			},
			{
				"[f",
				function()
					require("nvim-treesitter-textobjects.move")
            .goto_previous("@function.outer", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Prev function",
			},
			{
				"]c",
				function()
					require("nvim-treesitter-textobjects.move")
            .goto_next("@class.outer", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Next class",
			},
			{
				"[c",
				function()
					require("nvim-treesitter-textobjects.move")
            .goto_previous("@class.outer", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Prev class",
			},
			{
				"]a",
				function()
					require("nvim-treesitter-textobjects.move")
            .goto_next("@parameter.inner", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Next parameter",
			},
			{
				"[a",
				function()
					require("nvim-treesitter-textobjects.move")
            .goto_previous("@parameter.inner", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Prev parameter",
			},
      {
        "iC",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@codeblock.inner", "textobjects")
        end,
        mode = { "x", "o" },
        ft = md_ft,
        desc = "Code block (inner)",
      },
      {
        "aC",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@codeblock.outer", "textobjects")
        end,
        mode = { "x", "o" },
        ft = md_ft,
        desc = "Code block (outer)",
      },
      {
        "ie",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@emphasis.inner", "textobjects")
        end,
        mode = { "x", "o" },
        ft = md_ft,
        desc = "Emphasis (inner)",
      },
      {
        "ae",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@emphasis.outer", "textobjects")
        end,
        mode = { "x", "o" },
        ft = md_ft,
        desc = "Emphasis (outer)",
      },
      {
        "il",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@mdlink.inner", "textobjects")
        end,
        mode = { "x", "o" },
        ft = md_ft,
        desc = "Markdown link (inner)",
      },
      {
        "al",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@mdlink.outer", "textobjects")
        end,
        mode = { "x", "o" },
        ft = md_ft,
        desc = "Markdown link (outer)",
      },
		},
		opts = {
			select = {
				enable = true,
				lookahead = true,
				selection_modes = {
					["@function.outer"] = "V",
					["@class.outer"] = "V",
				},
			},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "BufReadPost",
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open all folds",
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
				desc = "Close all folds",
			},
			{
				"K",
				function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
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
		end,
		opts = {
			preview = {
				win_config = {
					winhighlight = "Normal:Folded",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
				},
			},
			provider_selector = function(_bufnr, _filetype, _buftype)
				return { "treesitter", "indent" }
			end,
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
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
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
		},
	},
}
