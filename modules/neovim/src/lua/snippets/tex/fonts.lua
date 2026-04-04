local ls = require("luasnip")
local snippet = ls.snippet
local snippet_node = ls.snippet_node
local txt_node = ls.text_node
local ins_node = ls.insert_node
local chc_node = ls.choice_node
local dyn_node = ls.dynamic_node
-- Visual placeholder
-- taken from https://ejmastnak.com/

local get_visual = function(args, parent, default_text)
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

return {

	snippet({ trig = "tny", name = "Tiny font size" }, {
		txt_node("\\tiny"),
	}),

	snippet({ trig = "scr", name = "Scriptize font size" }, {
		txt_node("\\scriptsize"),
	}),

	snippet({ trig = "fot", name = "Footnote size" }, {
		txt_node("\\footnotesize"),
	}),

	snippet({ trig = "sma", name = "Small font size" }, {
		txt_node("\\small"),
	}),

	snippet({ trig = "nor", name = "Normalsize font" }, {
		txt_node("\\normalsize"),
	}),

	snippet({ trig = "lar", name = "Large font size" }, {
		chc_node(1, {
			{
				ins_node(1, "\\large"),
			},
			{
				ins_node(1, "\\Large"),
			},
			{
				ins_node(1, "\\LARGE"),
			},
		}),
	}),

	snippet({ trig = "hug", name = "Huge font size" }, {
		chc_node(1, {
			{
				ins_node(1, "\\huge"),
			},
			{
				ins_node(1, "\\Huge"),
			},
		}),
	}),

	-- Standard font-changing commands and declarations

	snippet({ trig = "rm", name = "Roman family" }, {
		chc_node(1, {
			{
				txt_node("\\textrm{"),
				v(1, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\begin{rmfamily}"),
				v(1, "..."),
				txt_node("\\end{rmfamily}"),
			},
			{
				ins_node(1, "\\rmfamily"),
			},
		}),
	}),

	snippet({ trig = "sf", name = "Sans serif family" }, {
		chc_node(1, {
			{
				txt_node("\\textsf{"),
				v(1, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\begin{sffamily}"),
				v(1, "..."),
				txt_node("\\end{sffamily}"),
			},
			{
				ins_node(1, "\\sffamily"),
			},
		}),
	}),

	snippet({ trig = "tt", name = "Typewriter family" }, {
		chc_node(1, {
			{
				txt_node("\\texttt{"),
				v(1, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\begin{ttfamily}"),
				v(1, "..."),
				txt_node("\\end{ttfamily}"),
			},
			{
				ins_node(1, "\\ttfamily"),
			},
		}),
	}),

	snippet({ trig = "bf", name = "Bold series" }, {
		chc_node(1, {
			{
				txt_node("\\textbf{"),
				v(1, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\begin{bfseries}"),
				v(1, "..."),
				txt_node("\\end{bfseries}"),
			},
			{
				ins_node(1, "\\bfseries"),
			},
		}),
	}),

	snippet({ trig = "it", name = "Italic shape" }, {
		chc_node(1, {
			{
				txt_node("\\textit{"),
				v(1, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\begin{itshape}"),
				v(1, "..."),
				txt_node("\\end{itshape}"),
			},
			{
				ins_node(1, "\\itshape"),
			},
		}),
	}),

	snippet({ trig = "sc", name = "Small caps shape" }, {
		chc_node(1, {
			{
				txt_node("\\textsc{"),
				v(1, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\begin{scshape}"),
				v(1, "..."),
				txt_node("\\end{scshape}"),
			},
			{
				ins_node(1, "\\scshape"),
			},
		}),
	}),

	snippet({ trig = "em", name = "Emphasized text" }, {
		chc_node(1, {
			{
				txt_node("\\emph{"),
				v(1, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\begin{em}"),
				v(1, "..."),
				txt_node("\\end{em}"),
			},
			{
				ins_node(1, "\\em"),
			},
		}),
	}),

	snippet({ trig = "tn", name = "Main font" }, {
		chc_node(1, {
			{
				txt_node("\\textnormal{"),
				v(1, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\begin{normalfont}"),
				v(1, "..."),
				txt_node("\\end{normalfont}"),
			},
			{
				ins_node(1, "\\normalfont"),
			},
		}),
	}),
}
