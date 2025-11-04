if false then
	require("lazy")
	require("blink.cmp")
end

local types = require("luasnip.util.types")

---@type LazySpec
return {
	{
		'saghen/blink.cmp',
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
			{ "zbirenbaum/copilot.lua" },
			{
				"danymat/neogen",
				opts = { snippet_engine = "luasnip" },
			},
			{ "xzbdmw/colorful-menu.nvim", },
		},
		opts_extend = { "sources.default" },
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "enter",
				["<C-l>"] = {
					function()
						local ls = require("luasnip")
						if ls.expand_or_jumpable() then
							vim.schedule(function()
								ls.expand_or_jump()
							end)
							return true
						end
					end,
					function()
						local sug = require("copilot.suggestion")
						if sug.is_visible() then
							vim.schedule(function()
								sug.accept()
							end)
							return true
						end
					end,
					"select_and_accept",
					"fallback",
				},
				["<C-j>"] = {
					function()
						local ls = require("luasnip")
						if ls.choice_active() then
							vim.schedule(function()
								ls.change_choice(1)
							end)
							return true
						end
					end,
					function()
						local sug = require("copilot.suggestion")
						if sug.is_visible() and sug.has_next() then
							vim.schedule(function()
								sug.next()
							end)
							return true
						end
					end,
					"fallback",
				},
				["<C-k>"] = {
					function()
						local ls = require("luasnip")
						if ls.choice_active() then
							vim.schedule(function()
								ls.change_choice(-1)
							end)
							return true
						end
					end,
					function()
						-- no "sug.has_prev()" method so we just call prev() unconditionally
						local sug = require("copilot.suggestion")
						if sug.is_visible() then
							vim.schedule(function()
								sug.prev()
							end)
							return true
						end
					end,
					"fallback",
				},
				["<C-h>"] = {
					function()
						local ls = require("luasnip")
						if ls.jumpable(-1) then
							ls.jump(-1)
							return true
						end
					end,
					function()
						local sug = require("copilot.suggestion")
						if sug.is_visible() then
							vim.schedule(function()
								sug.accept_word()
							end)
							return true
						end
					end,
					"fallback",
				},
			},
			cmdline = {
				keymap = {
					["<CR>"] = { "accept", "fallback" },
				},
				completion = {
					menu = {
						auto_show = function(_)
							return vim.fn.getcmdtype() == ":"
						end,
					},
					list = {
						selection = {
							preselect = false,
						},
					},
				},
			},
			appearance = { nerd_font_variant = "normal" },
			snippets = {
				preset = "luasnip",
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
				},
				providers = {
					lsp = {
						timeout_ms = 2000,
					},
				},
			},
			signature = {
				enabled = true,
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
				ghost_text = {
					enabled = true,
				},
				list = {
					selection = {
						preselect = false,
					},
				},
				menu = {
					auto_show = true,
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "source_name" },
							{ "kind_icon" },
						},
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuOpen",
				callback = function()
					vim.b.copilot_suggestion_hidden = true
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuClose",
				callback = function()
					vim.b.copilot_suggestion_hidden = false
				end,
			})
		end
	},
	{
		"zbirenbaum/copilot.lua",
		optional = true,
		keys = {
			{
				"<Leader>aa",
				function() require("copilot.suggestion").accept() end,
				mode = {"i", "s"},
			},
			{
				"<Leader>aw",
				function() require("copilot.suggestion").accept_word() end,
				mode = {"i", "s"},
				desc = "Copilot: Accept Word"
			},
			{
				"<Leader>a]",
				function() require("copilot.suggestion").next() end,
				mode = {"i", "s"},
				desc = "Copilot: Next"
			},
			{
				"<Leader>a[",
				function() require("copilot.suggestion").prev() end,
				mode = {"i", "s"},
				desc = "Copilot: Prev"
			},
			{
				"<Leader>aq",
				function() require("copilot.suggestion").dismiss() end,
				mode = {"i", "s"},
				desc = "Copilot: Dismiss"
			},
		},
		opts = {
			filetypes = {
				markdown = true,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets", },
		event = "InsertEnter",
		keys = {
			{
				"<C-l>",
				function() require("luasnip").expand_or_jump() end,
				mode = { "i", "s" },
				desc = "LuaSnip: Expand/Jump forward"
			},
			{
				"<C-h>",
				function() require("luasnip").jump(-1) end,
				mode = { "i", "s" },
				desc = "LuaSnip: Jump backward"
			},
			{
				"<C-j>",
				function()
					local ls = require("luasnip")
					if ls.choice_active() then ls.change_choice(1) end
				end,
				mode = "i",
				desc = "LuaSnip: Choice next"
			},
			{
				"<C-k>",
				function()
					local ls = require("luasnip")
					if ls.choice_active() then ls.change_choice(-1) end
				end,
				mode = "i",
				desc = "LuaSnip: Choice prev"
			},
		},
		opts = {
			ext_opts = {
				-- Insert / placeholder nodes
				[types.insertNode] = {
					-- when cursor is inside this node
					active = {
						hl_group = "LuasnipNodeActive",
						priority = 200,
						hl_mode = "combine",
					},
					-- when node exists but isn't current
					passive = {
						hl_group = "LuasnipNodePassive",
						priority = 90,
						hl_mode = "combine",
					},
				},
				-- Choice nodes (add an eol badge when focused)
				[types.choiceNode] = {
					active = {
						hl_group = "LuasnipChoice",
						priority = 210,
						hl_mode = "combine",
						virt_text = { { " 󰼯 choice", "LuasnipHint" } }, -- glyph optional
						virt_text_pos = "eol",
					},
					passive = {
						hl_group = "LuasnipNodePassive",
						priority = 95,
						hl_mode = "combine",
					},
				},
				-- (Optional) whole-snippet region when *not* focused
				[types.snippetNode] = {
					passive = {
						hl_group = "LuasnipNodePassive",
						priority = 80,
						hl_mode = "combine",
					},
				},
			},
			keep_roots   = true,
			link_roots   = true,
			link_children = true,
			update_events = {
				"TextChanged" ,
				"TextChangedI",
			},
			delete_check_events = { "TextChanged", },
			region_check_events = {
				"CursorMoved",
				"CursorHold",
				"InsertEnter",
			},
			enable_autosnippets = true,
		},
		init = function()
			vim.api.nvim_set_hl(
				0,
				"LuasnipNodePassive",
				{ link = "Visual" }
			)
			vim.api.nvim_set_hl(
				0,
				"LuasnipNodeActive",
				{ link = "IncSearch" }
			)
			vim.api.nvim_set_hl(
				0,
				"LuasnipChoice",
				{ link = "Search" }
			)
			vim.api.nvim_set_hl(
				0,
				"LuasnipHint",
				{ link = "Comment" }
			)
		end,
		config = function(_, opts)
			local ls = require("luasnip")
			ls.setup(opts)
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/snippets" },
			})
			require("luasnip.loaders.from_lua").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
			})
		end,
	},
}
