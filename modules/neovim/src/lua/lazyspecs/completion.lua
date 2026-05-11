local function minuet_if_visible(method)
	return function()
		local vt = require("minuet.virtualtext")
		if vt.action.is_visible() then
			vim.schedule(function()
				vt.action[method]()
			end)
			return true
		end
	end
end

---@type LazySpec
return {
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
			{ "milanglacier/minuet-ai.nvim" },
			{ "xzbdmw/colorful-menu.nvim" },
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
					minuet_if_visible("accept"),
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
					minuet_if_visible("next"),
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
					minuet_if_visible("prev"),
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
					minuet_if_visible("accept_line"),
					"fallback",
				},
				["<C-S-Space>"] = {
					function(cmp)
						cmp.show({ providers = { "minuet" } })
					end,
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
					minuet = {
						name = "minuet",
						module = "minuet.blink",
						score_offset = 100,
						async = true,
						timeout_ms = 5000,
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
	},
	{
		"milanglacier/minuet-ai.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "InsertEnter",
		keys = {
			{
				"<leader>ap",
				function()
					local minuet = require("minuet")
					local presets = vim.tbl_keys(minuet.presets or {})
					vim.ui.select(presets, { prompt = "Minuet preset:" }, function(choice)
						if choice then
							minuet.change_preset(choice)
						end
					end)
				end,
				desc = "Minuet: Switch preset",
			},
			{
				"<leader>ap",
				function()
					require("minuet.duet").action.predict()
					vim.schedule(function()
						require("which-key").show({
							keys = "<leader>md",
							loop = true,
						})
					end)
				end,
				desc = "Minuet duet",
			},
			{
				"<leader>\\a",
				function()
					require("minuet.virtualtext").action.toggle_auto_trigger()
				end,
				mode = { "n", "i" },
				desc = "Minuet: Toggle auto-trigger",
			},
			{
				"<leader>app",
				function()
					require("minuet.duet").action.predict()
				end,
				desc = "Minuet duet: Predict edit",
			},
			{
				"<leader>apa",
				function()
					require("minuet.duet").action.apply()
				end,
				desc = "Minuet duet: Apply edit",
			},
			{
				"<leader>apx",
				function()
					require("minuet.duet").action.dismiss()
				end,
				desc = "Minuet duet: Dismiss",
			},
		},
		opts = {
			virtualtext = {
				auto_trigger_ft = {},
				keymap = {
					accept = nil,
					accept_line = nil,
					next = nil,
					prev = nil,
					dismiss = nil,
				},
			},
			presets = {
				local_ollama = {
					provider = "openai_fim_compatible",
					provider_options = {
						openai_fim_compatible = {
							api_key = "TERM",
							name = "Ollama",
							end_point = "http://localhost:11434/v1/completions",
							model = "qwen2.5-coder:14b-instruct-q8_0",
							optional = {
								max_tokens = 256,
								top_p = 0.9,
							},
						},
					},
					throttle = 500,
					debounce = 300,
				},
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		event = "InsertEnter",
		keys = {
			{
				"<C-l>",
				function()
					require("luasnip").expand_or_jump()
				end,
				mode = { "i", "s" },
				desc = "LuaSnip: Expand/Jump forward",
			},
			{
				"<C-h>",
				function()
					require("luasnip").jump(-1)
				end,
				mode = { "i", "s" },
				desc = "LuaSnip: Jump backward",
			},
			{
				"<C-j>",
				function()
					local ls = require("luasnip")
					if ls.choice_active() then
						ls.change_choice(1)
					end
				end,
				mode = "i",
				desc = "LuaSnip: Choice next",
			},
			{
				"<C-k>",
				function()
					local ls = require("luasnip")
					if ls.choice_active() then
						ls.change_choice(-1)
					end
				end,
				mode = "i",
				desc = "LuaSnip: Choice prev",
			},
		},
		opts = function()
			local types = require("luasnip.util.types")
			return {
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
				keep_roots = true,
				link_roots = true,
				link_children = true,
				update_events = {
					"TextChanged",
					"TextChangedI",
				},
				delete_check_events = { "TextChanged" },
				region_check_events = {
					"CursorMoved",
					"CursorHold",
					"InsertEnter",
				},
				enable_autosnippets = true,
			}
		end,
		init = function()
			vim.api.nvim_set_hl(0, "LuasnipNodePassive", { link = "Visual" })
			vim.api.nvim_set_hl(0, "LuasnipNodeActive", { link = "IncSearch" })
			vim.api.nvim_set_hl(0, "LuasnipChoice", { link = "Search" })
			vim.api.nvim_set_hl(0, "LuasnipHint", { link = "Comment" })
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
