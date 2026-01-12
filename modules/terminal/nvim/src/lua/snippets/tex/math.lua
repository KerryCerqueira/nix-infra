local ls = require("luasnip")
local snippet = ls.snippet
local snippet_node = ls.snippet_node
local txt_node = ls.text_node
local ins_node = ls.insert_node
local fn_node = ls.function_node
local chc_node = ls.choice_node
local dyn_node = ls.dynamic_node
local rst_node = ls.restore_node
local extras = require("luasnip.extras")
local rep = extras.rep

-- Auxiliary functions

-- Math zone context
-- taken from https://ejmastnak.com/

local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

-- Visual placeholder
-- taken from https://ejmastnak.com/

local get_visual = function(_, parent, default_text)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return snippet_node(nil, ins_node(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return snippet_node(nil, ins_node(1, default_text))
	end
end

local function v(pos, default_text)
	return dyn_node(pos, function(args, parent)
		return get_visual(args, parent, default_text)
	end)
end

-- Matrices and cases
-- taken from github.com/evesdropper

local generate_matrix = function(args, snip)
	local rows = tonumber(snip.captures[2])
	local cols = tonumber(snip.captures[3])
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		table.insert(nodes, rst_node(ins_indx, tostring(j) .. "x1", ins_node(1)))
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, txt_node(" & "))
			table.insert(nodes, rst_node(ins_indx, tostring(j) .. "x" .. tostring(k), ins_node(1)))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, txt_node({ " \\\\", "" }))
	end
	nodes[#nodes] = txt_node(" \\\\")
	return snippet_node(nil, nodes)
end

local generate_hom_matrix = function(args, snip)
	local rows = tonumber(snip.captures[2])
	local cols = tonumber(snip.captures[3])
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		if j == 1 then
			table.insert(nodes, rst_node(ins_indx, ins_node(1)))
			table.insert(nodes, txt_node("_{11}"))
		else
			table.insert(nodes, rep(1))
			table.insert(nodes, txt_node("_{" .. tostring(j) .. "1}"))
		end
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, txt_node(" & "))
			table.insert(nodes, rep(1))
			table.insert(nodes, txt_node("_{" .. tostring(j) .. tostring(k) .. "}"))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, txt_node({ " \\\\", "" }))
	end
	nodes[#nodes] = txt_node(" \\\\")
	return snippet_node(nil, nodes)
end

local generate_cases = function(args, snip)
	local rows = tonumber(snip.captures[1]) or 2
	local cols = 2
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		table.insert(
			nodes,
			rst_node(ins_indx, tostring(j) .. "x1", snippet_node(1, { txt_node("    \\hfil "), ins_node(1) }))
		)
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, txt_node(" & "))
			table.insert(nodes, rst_node(ins_indx, tostring(j) .. "x" .. tostring(k), ins_node(1)))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, txt_node({ " \\\\", "" }))
	end
	table.remove(nodes, #nodes)
	return snippet_node(nil, nodes)
end

return {

	-- Math

	-- Math alphabet identifiers

	snippet({ trig = "mc", name = "Calligraphic math font", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mathcal{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "mr", name = "Roman math font", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mathrm{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "mb", name = "Bold math font", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mathbf{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ms", name = "Sans serif math font", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mathsf{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "mt", name = "Typewriter math font", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mathtt{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "mn", name = "Normal math font", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mathnormal{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "mi", name = "Italic math font", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mathit{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "mf", name = "Euler Fraktur math font", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mathfrak{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "mk", name = "Blackboard bold math font", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mathbb{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	-- Display environments and alignment structures

	snippet({ trig = "mm", name = "Inline display", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("$"),
		dyn_node(1, get_visual),
		txt_node("$"),
	}),

	snippet({ trig = "en", name = "Generic environment" }, {
		txt_node("\\begin{"),
		ins_node(1, "env"),
		txt_node("}"),
		txt_node({ "", "" }),
		txt_node("    "),
		dyn_node(2, get_visual),
		txt_node({ "", "" }),
		txt_node("\\end{"),
		rep(1),
		txt_node("}"),
	}),

	snippet({ trig = "nn", name = "New equation" }, {
		chc_node(1, {
			{
				txt_node("\\begin{equation*}"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{equation*}"),
			},
			{
				txt_node("\\begin{equation}"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{equation}"),
			},
		}),
	}),

	snippet({ trig = "ml", name = "New multline" }, {
		chc_node(1, {
			{
				txt_node("\\begin{multline}"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{multline}"),
			},
			{
				txt_node("\\begin{multline*}"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{multline*}"),
			},
		}),
	}),

	snippet({ trig = "gap", name = "Multline gap" }, {
		txt_node("\\setlenght\\multlinegap{0pt}"),
	}),

	snippet({ trig = "sp", name = "New split" }, {
		txt_node("\\begin{split}"),
		txt_node({ "", "" }),
		txt_node("    "),
		dyn_node(1, get_visual),
		txt_node({ "", "" }),
		txt_node("\\end{split}"),
	}),

	snippet({ trig = "gg", name = "New gather" }, {
		chc_node(1, {
			{
				txt_node("\\begin{gather}"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{gather}"),
			},
			{
				txt_node("\\begin{gather*}"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{gather*}"),
			},
		}),
	}),

	snippet({ trig = "aa", name = "New align" }, {
		chc_node(1, {
			{
				txt_node("\\begin{align*}"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{align*}"),
			},
			{
				txt_node("\\begin{align}"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{align}"),
			},
		}),
	}),

	snippet({ trig = "fal", name = "New falign" }, {
		chc_node(1, {
			{
				txt_node("\\begin{falign}"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{falign}"),
			},
			{
				txt_node("\\begin{falign*}"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{falign*}"),
			},
		}),
	}),

	snippet({ trig = "(%d?)cs", name = "New cases environment", snippetType = "autosnippet", regTrig = true }, {
		txt_node("\\begin{cases}"),
		txt_node({ "", "" }),
		dyn_node(1, generate_cases),
		txt_node({ "", "" }),
		txt_node("\\end{cases}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "br", name = "Display line break", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\\\"),
		txt_node({ "", "" }),
		ins_node(1),
	}, { condition = in_mathzone }),

	snippet({ trig = "itr", name = "Short text between lines", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\intertext{"),
		v(1, "text"),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "tx", name = "Text inside display", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\text{"),
		v(1, "text"),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "dib", name = "Display page break", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\displaybreak"),
	}, { condition = in_mathzone }),

	snippet({ trig = "dis", name = "Displaystyle", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\displaystyle"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ty", name = "Textstyle", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\textstyle"),
	}, { condition = in_mathzone }),

	-- Equation numbering and tags

	snippet({ trig = "ntg", name = "Suppress equation tag", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\notag"),
	}, { condition = in_mathzone }),

	snippet({ trig = "tag", name = "Equation tag", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\tag{"),
				v(1, "tag"),
				txt_node("}"),
			},
			{
				txt_node("\\tag*{"),
				v(1, "tag"),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "teq", name = "Last number equation" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\theequation"),
	}),

	-- Matrix-like environments

	snippet({ trig = "([bBpvV])(%d+)x(%d+)", name = "New matrix", snippetType = "autosnippet", regTrig = true }, {
		txt_node("\\begin{"),
		fn_node(function(_, snip)
			return snip.captures[1] .. "matrix"
		end),
		txt_node("}"),
		txt_node({ "", "" }),
		dyn_node(1, generate_matrix),
		txt_node({ "", "" }),
		txt_node("\\end{"),
		fn_node(function(_, snip)
			return snip.captures[1] .. "matrix"
		end),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet(
		{ trig = "([bBpvV])(%d+)h(%d+)", name = "New homogeneous matrix", snippetType = "autosnippet", regTrig = true },
		{
			txt_node("\\begin{"),
			fn_node(function(_, snip)
				return snip.captures[1] .. "matrix"
			end),
			txt_node("}"),
			txt_node({ "", "" }),
			dyn_node(1, generate_hom_matrix),
			txt_node({ "", "" }),
			txt_node("\\end{"),
			fn_node(function(_, snip)
				return snip.captures[1] .. "matrix"
			end),
			txt_node("}"),
		},
		{ condition = in_mathzone }
	),

	snippet({ trig = "([bBpvV])gn", name = "New generic matrix", snippetType = "autosnippet", regTrig = true }, {
		txt_node("\\begin{"),
		fn_node(function(_, snip)
			return snip.captures[1] .. "matrix"
		end),
		txt_node("}"),
		txt_node({ "", "" }),
		txt_node("    "),
		ins_node(1),
		txt_node("_{11} & "),
		rep(1),
		txt_node("_{12} & \\cdots & "),
		rep(1),
		txt_node("_{1"),
		ins_node(2),
		txt_node("}"),
		txt_node(" \\\\"),
		txt_node({ "", "" }),
		txt_node("    "),
		rep(1),
		txt_node("_{21} & "),
		rep(1),
		txt_node("_{22} & \\cdots & "),
		rep(1),
		txt_node("_{2"),
		rep(2),
		txt_node("}"),
		txt_node(" \\\\"),
		txt_node({ "", "" }),
		txt_node("    "),
		txt_node("\\vdots & \\vdots & \\ddots & \\vdots \\\\"),
		txt_node({ "", "" }),
		txt_node("    "),
		rep(1),
		txt_node("_{"),
		ins_node(3),
		txt_node("1} & "),
		rep(1),
		txt_node("_{"),
		rep(3),
		txt_node("2} & \\cdots & "),
		rep(1),
		txt_node("_{"),
		rep(3),
		rep(2),
		txt_node("} \\\\"),
		txt_node({ "", "" }),
		txt_node("\\end{"),
		fn_node(function(_, snip)
			return snip.captures[1] .. "matrix"
		end),
		txt_node("}"),
	}, { condition = in_mathzone }),

	-- Subscripts and superscripts

	snippet({ trig = ";", name = "Short subscript", snippetType = "autosnippet", wordTrig = false }, {
		txt_node("_"),
	}, { condition = in_mathzone }),

	snippet({ trig = ":", name = "Subscript", snippetType = "autosnippet", wordTrig = false }, {
		txt_node("_{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "´", name = "Short superscript", snippetType = "autosnippet", wordTrig = false }, {
		txt_node("^"),
	}, { condition = in_mathzone }),

	snippet({ trig = "¨", name = "Superscript", snippetType = "autosnippet", wordTrig = false }, {
		txt_node("^{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "¨", name = "Superscript", snippetType = "autosnippet", wordTrig = false }, {
		txt_node("^{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "st", name = "Stacking", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\substack{"),
		dyn_node(1, get_visual),
		txt_node(" \\\\ "),
		ins_node(2),
		txt_node("}"),
	}, { condition = in_mathzone }),

	-- Compound structures

	snippet({ trig = "lxl", name = "Left relation arrow", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\xleftarrow{"),
				ins_node(1, "top"),
				txt_node("}"),
			},
			{
				txt_node("\\xleftarrow["),
				ins_node(1, "bottom"),
				txt_node("]{"),
				ins_node(2, "top"),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "lxr", name = "Left relation arrow", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\xrightarrow{"),
				ins_node(1, "top"),
				txt_node("}"),
			},
			{
				txt_node("\\xrightarrow["),
				ins_node(1, "bottom"),
				txt_node("]{"),
				ins_node(2, "top"),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "cf", name = "Continued fraction", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\cfrac{"),
				ins_node(1, "num"),
				txt_node("}{"),
				txt_node({ "", "" }),
				txt_node("    "),
				ins_node(2, "den"),
				txt_node({ "", "" }),
				txt_node("}"),
			},
			{
				txt_node("\\cfrac["),
				ins_node(1, "num-alignment"),
				txt_node("]{"),
				ins_node(2, "num"),
				txt_node("}{"),
				txt_node({ "", "" }),
				txt_node("    "),
				ins_node(3, "den"),
				txt_node({ "", "" }),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "bx", name = "Boxed formula", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\boxed{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ff", name = "Fraction", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\frac{"),
				ins_node(1),
				txt_node("}{"),
				ins_node(2),
				txt_node("}"),
			},
			{
				txt_node("\\dfrac{"),
				ins_node(1),
				txt_node("}{"),
				ins_node(2),
				txt_node("}"),
			},
			{
				txt_node("\\tfrac{"),
				ins_node(1),
				txt_node("}{"),
				ins_node(2),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "bm", name = "Binomial coefficient", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\binom{"),
				ins_node(1),
				txt_node("}{"),
				ins_node(2),
				txt_node("}"),
			},
			{
				txt_node("\\dbinom{"),
				ins_node(1),
				txt_node("}{"),
				ins_node(2),
				txt_node("}"),
			},
			{
				txt_node("\\tbinom{"),
				ins_node(1),
				txt_node("}{"),
				ins_node(2),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	-- Decorations

	snippet({ trig = "abv", name = "Place material above", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\overset{"),
		ins_node(1, "above"),
		txt_node("}{"),
		v(2, "material"),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "bel", name = "Place material below", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\underset{"),
		ins_node(1, "below"),
		txt_node("}{"),
		v(2, "material"),
		txt_node("}"),
	}, { condition = in_mathzone }),

	-- Limiting positions

	snippet({ trig = "lim", name = "Above/below operator", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\limits"),
	}, { condition = in_mathzone }),

	snippet({ trig = "nli", name = "Right of the operator", snippetType = "autosnippet" }, {
		txt_node("\\nolimits"),
	}, { condition = in_mathzone }),

	-- Relations

	snippet({ trig = "eq", name = "Congruence relation", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\equiv"),
	}, { condition = in_mathzone }),

	snippet({ trig = "md", name = "Mod operator", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Mod{"),
		ins_node(1),
		txt_node("}"),
	}, { condition = in_mathzone }),

	-- local macro
	snippet({ trig = "mod", name = "Modular relation", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "..."),
				txt_node(" \\equiv "),
				ins_node(2, "..."),
				txt_node(" \\pmod{"),
				ins_node(3, "..."),
				txt_node("}"),
			},
			{
				ins_node(1, "..."),
				txt_node(" \\not\\equiv "),
				ins_node(2, "..."),
				txt_node(" \\pmod{"),
				ins_node(3, "..."),
				txt_node("}"),
			},
			{
				ins_node(1, "..."),
				txt_node(" \\equiv "),
				ins_node(2, "..."),
				txt_node(" \\mod{"),
				ins_node(3, "..."),
				txt_node("}"),
			},
			{
				ins_node(1, "..."),
				txt_node(" \\not\\equiv "),
				ins_node(2, "..."),
				txt_node(" \\mod{"),
				ins_node(3, "..."),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "sbg", name = "Left triangle", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\vartriangleleft"),
			},
			{
				ins_node(1, "\\ntriangleleft"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "sgc", name = "Right triangle", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\vartriangleright"),
			},
			{
				ins_node(1, "\\ntriangleright"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "ne", name = "Not equal", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\ne"),
	}, { condition = in_mathzone }),

	snippet({ trig = "nr", name = "Relation negation", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\not"),
	}, { condition = in_mathzone }),

	snippet({ trig = "app", name = "Approx", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\approx"),
	}, { condition = in_mathzone }),

	snippet({ trig = "cn", name = "Congruent", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\cong"),
			},
			{
				ins_node(1, "\\ncong"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "le", name = "Less or equal", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\le"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ge", name = "Greater or equal", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\ge"),
	}, { condition = in_mathzone }),

	snippet({ trig = "pc", name = "Precedes", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\prec"),
			},
			{
				ins_node(1, "\\nprec"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "sx", name = "Succedes", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\succ"),
			},
			{
				ins_node(1, "\\nsucc"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "re", name = "Relation", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\sim"),
			},
			{
				ins_node(1, "\\nsim"),
			},
		}),
	}, { condition = in_mathzone }),

	-- Operators

	snippet({ trig = "opr", name = "Define new operator" }, {
		chc_node(1, {
			{
				txt_node("\\DeclareMathOperator{"),
				ins_node(1, "cmd"),
				txt_node("}{"),
				ins_node(2, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\DeclareMathOperator*{"),
				ins_node(1, "cmd"),
				txt_node("}{"),
				ins_node(2, "text"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "ce", name = "Ceiling", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\lceil "),
				dyn_node(1, get_visual),
				txt_node(" \\rceil"),
			},
			{
				txt_node("\\left\\lceil "),
				dyn_node(1, get_visual),
				txt_node(" \\right\\rceil"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "fl", name = "Floor", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\lfloor "),
				dyn_node(1, get_visual),
				txt_node(" \\rfloor"),
			},
			{
				txt_node("\\left\\lfloor "),
				dyn_node(1, get_visual),
				txt_node(" \\right\\rfloor"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "sq", name = "Square root", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\sqrt{"),
				dyn_node(1, get_visual),
				txt_node("}"),
			},
			{
				txt_node("\\sqrt["),
				ins_node(1, "n-th"),
				txt_node("]{"),
				dyn_node(2, get_visual),
				txt_node("}"),
			},
			{
				txt_node("\\sqrt[\\leftroot{"),
				ins_node(1, "x"),
				txt_node("}\\uproot{"),
				ins_node(2, "y"),
				txt_node("} "),
				ins_node(3, "n-th"),
				txt_node("]{"),
				dyn_node(4, get_visual),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "imp", name = "Imaginary part", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Im"),
	}, { condition = in_mathzone }),

	snippet({ trig = "rpa", name = "Real part", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Re"),
	}, { condition = in_mathzone }),

	snippet({ trig = "opm", name = "Mod operator", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		ins_node(1, "..."),
		txt_node(" \\bmod "),
		ins_node(2, "..."),
	}, { condition = in_mathzone }),

	snippet({ trig = "mp", name = "Minus plus", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mp"),
	}, { condition = in_mathzone }),

	snippet({ trig = "pm", name = "Plus minus", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\pm"),
	}, { condition = in_mathzone }),

	snippet({ trig = "tm", name = "Times", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\times"),
	}, { condition = in_mathzone }),

	snippet({ trig = "cd", name = "Centered dot", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\cdot"),
	}, { condition = in_mathzone }),

	snippet({ trig = "cir", name = "Circle", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\circ"),
	}, { condition = in_mathzone }),

	snippet({ trig = "opl", name = "Oplus", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\oplus"),
	}, { condition = in_mathzone }),

	snippet({ trig = "omt", name = "Otimes", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\otimes"),
	}, { condition = in_mathzone }),

	snippet({ trig = "dv", name = "Middle bar", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mid"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ndv", name = "Middle bar", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\centernot\\mid"),
	}, { condition = in_mathzone }),

	snippet({ trig = "xm", name = "Maximum", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\max"),
			},
			{
				txt_node("\\max_{"),
				ins_node(1, "..."),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "mu", name = "Minimum", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\min"),
			},
			{
				txt_node("\\min_{"),
				ins_node(1, "..."),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "nf", name = "Infimum", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\inf"),
			},
			{
				txt_node("\\inf_{"),
				ins_node(1, "..."),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "sr", name = "Supremum", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\sup"),
			},
			{
				txt_node("\\sup_{"),
				ins_node(1, "..."),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "arg", name = "Argument", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arg"),
	}, { condition = in_mathzone }),

	snippet({ trig = "deg", name = "Degree", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\deg"),
	}, { condition = in_mathzone }),

	snippet({ trig = "det", name = "Determinant", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\det"),
	}, { condition = in_mathzone }),

	snippet({ trig = "dim", name = "Dimension", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\dim"),
	}, { condition = in_mathzone }),

	snippet({ trig = "gc", name = "Greatest common divisor", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\gcd"),
	}, { condition = in_mathzone }),

	snippet({ trig = "hm", name = "Hom", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\hom"),
	}, { condition = in_mathzone }),

	snippet({ trig = "kr", name = "Kernel", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\ker"),
	}, { condition = in_mathzone }),

	snippet({ trig = "lap", name = "Laplacian", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\nabla^2 "),
	}, { condition = in_mathzone }),

	snippet({ trig = "div", name = "Divergence", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\nabla\\cdot\\vv{"),
				ins_node(1),
				txt_node("}"),
			},
			{
				txt_node("\\nabla\\cdot\\vec{"),
				ins_node(1),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "cur", name = "Curl", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\nabla\\times\\vv{"),
				ins_node(1),
				txt_node("}"),
			},
			{
				txt_node("\\nabla\\times\\vec{"),
				ins_node(1),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "ba", name = "Bra", snippetType = "autosnippet" }, {
		chc_node(1, {
			{
				txt_node("\\bra{"),
				ins_node(1),
				txt_node("}"),
			},
			{
				txt_node("\\bra*{"),
				ins_node(1),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "kt", name = "Ket", snippetType = "autosnippet" }, {
		chc_node(1, {
			{
				txt_node("\\ket{"),
				ins_node(1),
				txt_node("}"),
			},
			{
				txt_node("\\ket*{"),
				ins_node(1),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "bk", name = "Braket", snippetType = "autosnippet" }, {
		chc_node(1, {
			{
				txt_node("\\braket{"),
				ins_node(1),
				txt_node("}{"),
				ins_node(2),
				txt_node("}"),
			},
			{
				txt_node("\\braket*{"),
				ins_node(1),
				txt_node("}{"),
				ins_node(2),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	-- Operators with limits

	snippet({ trig = "lm", name = "Limit", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\lim_{"),
				ins_node(1),
				txt_node(" \\to "),
				ins_node(2),
				txt_node("}"),
			},
			{
				ins_node(1, "\\lim"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "lif", name = "liminf", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\liminf_{"),
				ins_node(1),
				txt_node(" \\to "),
				ins_node(2),
				txt_node("}"),
			},
			{
				ins_node(1, "\\liminf"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "lsu", name = "limsup", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\limsup_{"),
				ins_node(1),
				txt_node(" \\to "),
				ins_node(2),
				txt_node("}"),
			},
			{
				ins_node(1, "\\limsup"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "lvf", name = "varliminf", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\varliminf_{"),
				ins_node(1),
				txt_node(" \\to "),
				ins_node(2),
				txt_node("}"),
			},
			{
				ins_node(1, "\\varliminf"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "lvu", name = "varlimsup", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\varlimsup_{"),
				ins_node(1),
				txt_node(" \\to "),
				ins_node(2),
				txt_node("}"),
			},
			{
				ins_node(1, "\\varlimsup"),
			},
		}),
	}, { condition = in_mathzone }),

	-- Functions

	snippet({ trig = "fn", name = "Function domain and codomain", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		ins_node(1, "fun"),
		txt_node(" : "),
		ins_node(2, "dom"),
		txt_node(" \\longrightarrow "),
		ins_node(3, "cod"),
	}, { condition = in_mathzone }),

	snippet({ trig = "fd", name = "Function definition" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\begin{align*}"),
		txt_node({ "", "" }),
		txt_node("    "),
		ins_node(1, "fun"),
		txt_node(" : "),
		ins_node(2, "dom"),
		txt_node(" & \\longrightarrow "),
		ins_node(3, "cod"),
		txt_node(" \\\\"),
		txt_node({ "", "" }),
		txt_node("    "),
		ins_node(4, "point"),
		txt_node(" & \\longmapsto "),
		ins_node(5, "img"),
		txt_node({ "", "" }),
		txt_node("\\end{align*}"),
	}),

	snippet({ trig = "sin", name = "sin", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\sin"),
	}, { condition = in_mathzone }),

	snippet({ trig = "cos", name = "cos", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\cos"),
	}, { condition = in_mathzone }),

	snippet({ trig = "tan", name = "tan", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\tan"),
	}, { condition = in_mathzone }),

	snippet({ trig = "cot", name = "cot", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\cot"),
	}, { condition = in_mathzone }),

	snippet({ trig = "sec", name = "sec", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\sec"),
	}, { condition = in_mathzone }),

	snippet({ trig = "cc", name = "csc", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\csc"),
	}, { condition = in_mathzone }),

	snippet({ trig = "asin", name = "arcsin", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arcsin"),
	}, { condition = in_mathzone }),

	snippet({ trig = "acos", name = "arccos", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arccos"),
	}, { condition = in_mathzone }),

	snippet({ trig = "atan", name = "arctan", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arctan"),
	}, { condition = in_mathzone }),

	snippet({ trig = "acot", name = "arccot", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arccot"),
	}, { condition = in_mathzone }),

	snippet({ trig = "asec", name = "arcsec", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arcsec"),
	}, { condition = in_mathzone }),

	snippet({ trig = "acc", name = "arccsc", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arccsc"),
	}, { condition = in_mathzone }),

	snippet({ trig = "sinh", name = "sinh", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\sinh"),
	}, { condition = in_mathzone }),

	snippet({ trig = "cosh", name = "cosh", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\cosh"),
	}, { condition = in_mathzone }),

	snippet({ trig = "tanh", name = "tanh", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\tanh"),
	}, { condition = in_mathzone }),

	snippet({ trig = "coth", name = "coth", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\coth"),
	}, { condition = in_mathzone }),

	snippet({ trig = "sch", name = "sech", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\sech"),
	}, { condition = in_mathzone }),

	snippet({ trig = "hcc", name = "csch", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\csch"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ahsin", name = "arcsinh", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arcsinh"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ahcos", name = "arccosh", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arccosh"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ahtan", name = "arctanh", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arctanh"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ahcot", name = "arccoth", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arccoth"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ahsec", name = "arcsech", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arcsech"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ahcc", name = "arccsch", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\arccsch"),
	}, { condition = in_mathzone }),

	snippet({ trig = "xp", name = "exp", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\exp"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ln", name = "ln", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\ln"),
	}, { condition = in_mathzone }),

	snippet({ trig = "lg", name = "log", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\log"),
	}, { condition = in_mathzone }),

	-- Ellipsis

	snippet({ trig = "dd", name = "Lower dots", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\ldots"),
	}, { condition = in_mathzone }),

	snippet({ trig = "cr", name = "Centered dots", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\cdots"),
	}, { condition = in_mathzone }),

	snippet({ trig = "vd", name = "Vertical dots", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\vdots"),
	}, { condition = in_mathzone }),

	snippet({ trig = "gd", name = "Diagonal dots", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\ddots"),
	}, { condition = in_mathzone }),

	snippet({ trig = "cln", name = "Colon", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node(":"),
	}, { condition = in_mathzone }),

	snippet({ trig = "sln", name = "Semicolon", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node(";"),
	}, { condition = in_mathzone }),

	-- Horizontal extensions

	snippet({ trig = "ovr", name = "Overline", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\overline{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "und", name = "Underline", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\underline{"),
		dyn_node(1, get_visual),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ovb", name = "Overbrace", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\overbrace{"),
		dyn_node(1, get_visual),
		txt_node("}^{"),
		ins_node(2, "top"),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "unb", name = "Underbrace", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\underbrace{"),
		dyn_node(1, get_visual),
		txt_node("}_{"),
		ins_node(2, "bottom"),
		txt_node("}"),
	}, { condition = in_mathzone }),

	-- Delimiters

	snippet({ trig = "dp", name = "Parenthesis", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\left( "),
		dyn_node(1, get_visual),
		txt_node(" \\right)"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ds", name = "Brackets", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\left[ "),
		dyn_node(1, get_visual),
		txt_node(" \\right]"),
	}, { condition = in_mathzone }),

	snippet({ trig = "bb", name = "Braces", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\{ "),
		dyn_node(1, get_visual),
		txt_node(" \\}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "db", name = "Extensible braces", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\left\\{ "),
		dyn_node(1, get_visual),
		txt_node(" \\right\\}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "dk", name = "Angle brackets", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\left\\langle "),
				dyn_node(1, get_visual),
				txt_node(" \\right\\rangle"),
			},
			{
				txt_node("\\langle "),
				dyn_node(1, get_visual),
				txt_node(" \\rangle"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "da", name = "Pipes", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\left\\lvert "),
				dyn_node(1, get_visual),
				txt_node(" \\right\\rvert"),
			},
			{
				txt_node("\\lvert "),
				dyn_node(1, get_visual),
				txt_node(" \\rvert"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "dn", name = "Double pipes", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\left\\lVert "),
				dyn_node(1, get_visual),
				txt_node(" \\right\\rVert"),
			},
			{
				txt_node("\\lVert "),
				dyn_node(1, get_visual),
				txt_node(" \\rVert"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "big", name = "Big-d delimiters", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\big"),
			},
			{
				ins_node(1, "\\Big"),
			},
			{
				ins_node(1, "\\bigg"),
			},
			{
				ins_node(1, "\\Bigg"),
			},
		}),
	}, { condition = in_mathzone }),

	-- Spacing commands

	snippet({ trig = "thp", name = "Thin space", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\,"),
	}, { condition = in_mathzone }),

	snippet({ trig = "mdn", name = "Medium space", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\:"),
	}, { condition = in_mathzone }),

	snippet({ trig = "tkp", name = "Thick space", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\;"),
	}, { condition = in_mathzone }),

	snippet({ trig = "enp", name = "Enskip", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\enskip"),
	}, { condition = in_mathzone }),

	snippet({ trig = "qu", name = "Quad", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\quad"),
	}, { condition = in_mathzone }),

	snippet({ trig = "qq", name = "Double quad", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\qquad"),
	}, { condition = in_mathzone }),

	snippet({ trig = "thn", name = "Negative thin space", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\!"),
	}, { condition = in_mathzone }),

	snippet({ trig = "men", name = "Negative medium space", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\negmedspace"),
	}, { condition = in_mathzone }),

	snippet({ trig = "tkn", name = "Negative thick space", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\negthickspace"),
	}, { condition = in_mathzone }),

	snippet({ trig = "hs", name = "Horizontal space", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\hspace{"),
		ins_node(1),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "vs", name = "Vertical space", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\vspace{"),
		ins_node(1),
		txt_node("}"),
	}, { condition = in_mathzone }),

	-- Greek alphabet

	snippet({ trig = "[.]a", name = "Alpha", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\alpha"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]b", name = "Beta", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\beta"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]c", name = "Chi", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\chi"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]D", name = "Uppercase delta", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Delta"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]d", name = "Lowercase delta", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\delta"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]e", name = "Epsilon", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\varepsilon"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]G", name = "Uppercase gamma", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Gamma"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]g", name = "Lowercase gamma", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\gamma"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]h", name = "Eta", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\eta"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]i", name = "Iota", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\iota"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]k", name = "Kappa", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\kappa"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]L", name = "Uppercase lambda", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Lambda"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]l", name = "Lowercase lambda", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\lambda"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]m", name = "Mu", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mu"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]n", name = "Nu", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\nu"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]O", name = "Uppercase omega", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Omega"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]o", name = "Lowercase omega", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\omega"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]Ph", name = "Uppercase phi", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Phi"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]ph", name = "Lowecase phi", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\varphi"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]Pi", name = "Uppercase pi", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Pi"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]pi", name = "Lowercase pi", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\pi"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]Ps", name = "Uppercase psi", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Psi"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]ps", name = "Lowercase psi", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\psi"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]r", name = "Rho", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\rho"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]S", name = "Uppercase sigma", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Sigma"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]s", name = "Lowercase sigma", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\sigma"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]ta", name = "Tau", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\tau"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]Th", name = "Uppercase theta", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Theta"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]th", name = "Lowercase theta", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\theta"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]U", name = "Uppercase upsilon", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Upsilon"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]u", name = "Lowecase upsilon", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\upsilon"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]X", name = "Uppercase xi", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\Xi"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]x", name = "Lowercase xi", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\xi"),
	}, { condition = in_mathzone }),

	snippet({ trig = "[.]z", name = "Zeta", snippetType = "autosnippet", regTrig = true }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\zeta"),
	}, { condition = in_mathzone }),

	-- Letter-shaped symbols

	snippet({ trig = "ha", name = "Aleph", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\aleph"),
	}, { condition = in_mathzone }),

	snippet({ trig = "hb", name = "Beth", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\beth"),
	}, { condition = in_mathzone }),

	snippet({ trig = "hd", name = "Daleth", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\daleth"),
	}, { condition = in_mathzone }),

	snippet({ trig = "hg", name = "Gimel", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\gimel"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ll", name = "ell", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\ell"),
	}, { condition = in_mathzone }),

	snippet({ trig = "cm", name = "Set complement", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\complement"),
	}, { condition = in_mathzone }),

	snippet({ trig = "hr", name = "hbar", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\hbar"),
	}, { condition = in_mathzone }),

	snippet({ trig = "hl", name = "hslash", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\hslash"),
	}, { condition = in_mathzone }),

	snippet({ trig = "pt", name = "Partial", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\partial"),
	}, { condition = in_mathzone }),

	-- Miscellaneous symbols

	snippet({ trig = "dl", name = "Dollar sign", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\$"),
	}, { condition = in_mathzone }),

	snippet({ trig = "hh", name = "Numeral", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\#"),
	}, { condition = in_mathzone }),

	snippet({ trig = "fy", name = "Infinity", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\infty"),
	}, { condition = in_mathzone }),

	snippet({ trig = "pr", name = "Prime", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\prime"),
	}, { condition = in_mathzone }),

	snippet({ trig = "per", name = "Percentaje", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\%"),
	}, { condition = in_mathzone }),

	snippet({ trig = "amp", name = "Ampersand", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\&"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ang", name = "Angle", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\angle"),
	}, { condition = in_mathzone }),

	snippet({ trig = "nb", name = "Nabla", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\nabla"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ch", name = "Section symbol" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\S"),
	}),

	-- Accents

	snippet({ trig = "dr", name = "Dot accent", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\dot{"),
				v(1, "..."),
				txt_node("}"),
			},
			{
				txt_node("\\ddot{"),
				v(1, "..."),
				txt_node("}"),
			},
			{
				txt_node("\\dddot{"),
				v(1, "..."),
				txt_node("}"),
			},
			{
				txt_node("\\ddddot{"),
				v(1, "..."),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "ht", name = "Hat", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\hat{"),
				v(1, "..."),
				txt_node("}"),
			},
			{
				txt_node("\\widehat{"),
				v(1, "..."),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "rng", name = "Math ring", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\mathring{"),
		v(1, "..."),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "til", name = "Tilde", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\tilde{"),
				ins_node(1),
				txt_node("}"),
			},
			{
				txt_node("\\widetilde{"),
				ins_node(1),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "vv", name = "Vector", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\vv{"),
				v(1, "..."),
				txt_node("}"),
			},
			{
				txt_node("\\vec{"),
				v(1, "..."),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	-- Logic

	snippet({ trig = "fa", name = "For all", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\forall"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ex", name = "Exists", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\exists"),
	}, { condition = in_mathzone }),

	snippet({ trig = "nx", name = "Not exist", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\nexists"),
	}, { condition = in_mathzone }),

	snippet({ trig = "lt", name = "Logic negation", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\lnot"),
	}, { condition = in_mathzone }),

	snippet({ trig = "lan", name = "Logic and", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\land"),
	}, { condition = in_mathzone }),

	snippet({ trig = "lor", name = "Logic or", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\lor"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ip", name = "Implies", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\implies"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ib", name = "Implied by", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\impliedby"),
	}, { condition = in_mathzone }),

	snippet({ trig = "iff", name = "If and only if", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\iff"),
	}, { condition = in_mathzone }),

	-- Sets and inclusion

	snippet({ trig = "in", name = "Belongs to", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\in"),
	}, { condition = in_mathzone }),

	snippet({ trig = "ntn", name = "Not in", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\notin"),
	}, { condition = in_mathzone }),

	snippet({ trig = "na", name = "Owns", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\ni"),
	}, { condition = in_mathzone }),

	snippet({ trig = "vc", name = "Empty set", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\emptyset"),
			},
			{
				ins_node(1, "\\varnothing"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "nun", name = "Union", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\cup"),
	}, { condition = in_mathzone }),

	snippet({ trig = "bun", name = "Big union", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\bigcup"),
	}, { condition = in_mathzone }),

	snippet({ trig = "sun", name = "Big subscript union", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\bigcup_{"),
		ins_node(1),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "dun", name = "Big definite union", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\bigcup_{"),
		ins_node(1),
		txt_node("}^{"),
		ins_node(2),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "nit", name = "Intersection", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\cap"),
	}, { condition = in_mathzone }),

	snippet({ trig = "bit", name = "Big intersection", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\bigcap"),
	}, { condition = in_mathzone }),

	snippet({ trig = "sit", name = "Big subscript intersection", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\bigcap_{"),
		ins_node(1),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "dit", name = "Big definite intersection", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\bigcap_{"),
		ins_node(1),
		txt_node("}^{"),
		ins_node(2),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "sf", name = "Set difference", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\setminus"),
	}, { condition = in_mathzone }),

	snippet({ trig = "sbs", name = "Subset", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\subset"),
	}, { condition = in_mathzone }),

	snippet({ trig = "sbq", name = "Subset or equals", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\subseteq"),
			},
			{
				ins_node(1, "\\nsubseteq"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "sus", name = "Contains", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\supset"),
	}, { condition = in_mathzone }),

	snippet({ trig = "suq", name = "Contains or equals", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\supseteq"),
			},
			{
				ins_node(1, "\\nsupseteq"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "setd", name = "Dots set", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\{ "),
		ins_node(1),
		txt_node(" \\std "),
		ins_node(2),
		txt_node(" \\}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "setb", name = "Bar set", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\{ "),
		ins_node(1),
		txt_node(" \\mid "),
		ins_node(2),
		txt_node(" \\}"),
	}, { condition = in_mathzone }),

	-- Arrows

	snippet({ trig = "rar", name = "Long right arrow", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\longrightarrow"),
	}, { condition = in_mathzone }),

	snippet({ trig = "lar", name = "Long left arrow", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\longleftarrow"),
	}, { condition = in_mathzone }),

	snippet({ trig = "to", name = "Long maps to", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\longmapsto"),
	}, { condition = in_mathzone }),

	-- Sums

	snippet({ trig = "sm", name = "Subscript sum", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\sum_{"),
				ins_node(1),
				txt_node("}"),
			},
			{
				ins_node(1, "\\sum"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "ss", name = "Definite sum", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\sum_{"),
		ins_node(1),
		txt_node("}^{"),
		ins_node(2),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "sos", name = "Subscript o-sum", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\bigoplus_{"),
		ins_node(1),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "nos", name = "Definite o-sum", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\bigoplus_{"),
		ins_node(1),
		txt_node("}^{"),
		ins_node(2),
		txt_node("}"),
	}, { condition = in_mathzone }),

	-- Products

	snippet({ trig = "sp", name = "Subscript product", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\prod_{"),
				ins_node(1),
				txt_node("}"),
			},
			{
				ins_node(1, "\\prod"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "pp", name = "Definite product", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\prod_{"),
		ins_node(1),
		txt_node("}^{"),
		ins_node(2),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "sop", name = "Subscript o-product", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\bigotimes_{"),
		ins_node(1),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "nop", name = "Definite o-product", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\bigotimes_{"),
		ins_node(1),
		txt_node("}^{"),
		ins_node(2),
		txt_node("}"),
	}, { condition = in_mathzone }),

	-- Derivatives

	snippet({ trig = "df", name = "Differential", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\dx{"),
		ins_node(1),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "der", name = "Derivative", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\der{"),
				ins_node(1, "func"),
				txt_node("}{"),
				ins_node(2, "var"),
				txt_node("}"),
			},
			{
				txt_node("\\Der{"),
				ins_node(1, "func"),
				txt_node("}{"),
				ins_node(2, "var"),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "ndr", name = "n-th derivative", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\ndr{"),
				ins_node(1, "n"),
				txt_node("}{"),
				ins_node(2, "func"),
				txt_node("}{"),
				ins_node(3, "var"),
				txt_node("}"),
			},
			{
				txt_node("\\Ndr{"),
				ins_node(1, "n"),
				txt_node("}{"),
				ins_node(2, "func"),
				txt_node("}{"),
				ins_node(3, "var"),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "pdr", name = "Partial derivative", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\pdr{"),
				ins_node(1, "func"),
				txt_node("}{"),
				ins_node(2, "var"),
				txt_node("}"),
			},
			{
				txt_node("\\Pdr{"),
				ins_node(1, "func"),
				txt_node("}{"),
				ins_node(2, "var"),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "npd", name = "n-th partial derivative", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\npd{"),
				ins_node(1, "n"),
				txt_node("}{"),
				ins_node(2, "func"),
				txt_node("}{"),
				ins_node(3, "var"),
				txt_node("}"),
			},
			{
				txt_node("\\Npd{"),
				ins_node(1, "n"),
				txt_node("}{"),
				ins_node(2, "func"),
				txt_node("}{"),
				ins_node(3, "var"),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "evl", name = "Derivative evaluation", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\evl{"),
		ins_node(1),
		txt_node("}"),
	}, { condition = in_mathzone }),

	-- Integrals

	snippet({ trig = "itn", name = "Integral", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\int"),
			},
			{
				ins_node(1, "\\oint"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "its", name = "Subscript integral", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\int_{"),
				ins_node(1),
				txt_node("}"),
			},
			{
				txt_node("\\oint_{"),
				ins_node(1),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "itd", name = "Definite integral", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\int_{"),
		ins_node(1),
		txt_node("}^{"),
		ins_node(2),
		txt_node("}"),
	}, { condition = in_mathzone }),

	snippet({ trig = "itbn", name = "Double integral", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\iint"),
			},
			{
				ins_node(1, "\\oiint"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "itbs", name = "Double integral subscript", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\iint_{"),
				ins_node(1),
				txt_node("}"),
			},
			{
				txt_node("\\oiint_{"),
				ins_node(1),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "ittn", name = "Triple integral", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\iiint"),
			},
			{
				ins_node(1, "\\oiiint"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "itts", name = "Triple integral subscript", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\iiint_{"),
				ins_node(1),
				txt_node("}"),
			},
			{
				txt_node("\\oiiint_{"),
				ins_node(1),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "itqn", name = "Quadruple integral", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				ins_node(1, "\\iiiint"),
			},
			{
				ins_node(1, "\\oiiint"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "itqs", name = "Quadruple integral subscript", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		chc_node(1, {
			{
				txt_node("\\iiint_{"),
				ins_node(1),
				txt_node("}"),
			},
			{
				txt_node("\\oiiint_{"),
				ins_node(1),
				txt_node("}"),
			},
		}),
	}, { condition = in_mathzone }),

	snippet({ trig = "itmn", name = "Multiple integral", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\idotsint"),
	}, { condition = in_mathzone }),

	snippet({ trig = "itms", name = "Multiple integral subscript", snippetType = "autosnippet" }, {
		fn_node(function(_, snip)
			return snip.captures[1]
		end),
		txt_node("\\idotsint_{"),
		ins_node(1),
		txt_node("}"),
	}, { condition = in_mathzone }),
}
