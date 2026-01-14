local ls = require("luasnip")
local snippet = ls.snippet
local snippet_node = ls.snippet_node
local txt_node = ls.text_node
local ins_node = ls.insert_node
local chc_node = ls.choice_node
local dyn_node = ls.dynamic_node
local extras = require("luasnip.extras")
local rep = extras.rep

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

return {

	-- Formatting

	-- Text and pages

	snippet({ trig = "url", name = "URLs" }, {
		txt_node("\\url{"),
		v(1, "url"),
		txt_node("}"),
	}),

	snippet({ trig = "ca", name = "Cancel stroke" }, {
		txt_node("\\cancel{"),
		v(1, "text"),
		txt_node("}"),
	}),

	snippet({ trig = "vrb", name = "Short verbatim" }, {
		txt_node("\\verb="),
		v(1, "text"),
		txt_node("="),
	}),

	snippet({ trig = "ltr", name = "Enlarged letter" }, {
		chc_node(1, {
			{
				txt_node("\\lettrine{"),
				ins_node(1, "initial"),
				txt_node("}{"),
				v(2, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\lettrine["),
				ins_node(1, "val-list"),
				txt_node("]{"),
				ins_node(2, "initial"),
				txt_node("}{"),
				v(3, "text"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "pht", name = "Phantom text" }, {
		chc_node(1, {
			{
				txt_node("\\phantom{"),
				v(1, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\hphantom{"),
				v(1, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\vphantom{"),
				v(1, "text"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "foo", name = "Footnote" }, {
		txt_node("\\footnote{"),
		v(1, "text"),
		txt_node("}"),
	}),

	snippet({ trig = "mrg", name = "Marginal note" }, {
		txt_node("\\marginpar{"),
		v(1, "text"),
		txt_node("}"),
	}),

	snippet({ trig = "npg", name = "New page" }, {
		txt_node("\\newpage"),
	}),

	snippet({ trig = "pp", name = "Paragraph break" }, {
		txt_node({ "", "" }),
		txt_node("\\bigskip"),
		txt_node({ "", "" }),
		txt_node({ "", "" }),
	}),

	snippet({ trig = "fbo", name = "Frame box" }, {
		chc_node(1, {
			{
				txt_node("\\fbox{"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("}"),
			},
			{
				txt_node("\\fbox{"),
				dyn_node(1, get_visual),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "fco", name = "Color frame box" }, {
		chc_node(1, {
			{
				txt_node("\\fcolorbox{"),
				ins_node(1, "border-color"),
				txt_node("}{"),
				ins_node(2, "bg-color"),
				txt_node("}{"),
				txt_node({ "", "" }),
				txt_node("    "),
				dyn_node(3, get_visual),
				txt_node({ "", "" }),
				txt_node("}"),
			},
			{
				txt_node("\\fcolorbox{"),
				ins_node(1, "border-color"),
				txt_node("}{"),
				ins_node(2, "bg-color"),
				txt_node("}{"),
				dyn_node(3, get_visual),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "cen", name = "Centered environment" }, {
		txt_node("\\begin{center}"),
		txt_node({ "", "" }),
		txt_node("    "),
		dyn_node(1, get_visual),
		txt_node({ "", "" }),
		txt_node("\\end{center}"),
	}),

	snippet({ trig = "min", name = "Minpage environment" }, {
		txt_node("\\begin{minipage}{\\linewidth-3\\fboxsep-3\\fboxrule}"),
		txt_node({ "", "" }),
		txt_node("    "),
		dyn_node(1, get_visual),
		txt_node({ "", "" }),
		txt_node("\\end{minipage}"),
	}),

	snippet({ trig = "code", name = "Code chunk" }, {
		chc_node(1, {
			{
				txt_node("{"),
				txt_node({ "", "" }),
				txt_node("\\renewcommand\\ttdefault{cmtt}"),
				txt_node({ "", "" }),
				txt_node("    \\begin{adjustwidth}{12mm+2mm}{2mm}"),
				txt_node({ "", "" }),
				txt_node("        \\lstinputlisting{"),
				ins_node(1),
				txt_node("}"),
				txt_node({ "", "" }),
				txt_node("    \\end{adjustwidth}"),
				txt_node({ "", "" }),
				txt_node({ "", "" }),
				txt_node("}"),
			},
			{
				txt_node("{"),
				txt_node({ "", "" }),
				txt_node("\\renewcommand\\ttdefault{cmtt}"),
				txt_node({ "", "" }),
				txt_node("\\begin{adjustwidth}{12mm+2mm}{2mm}"),
				txt_node({ "", "" }),
				txt_node("\\begin{lstlisting}"),
				txt_node({ "", "" }),
				ins_node(1),
				txt_node({ "", "" }),
				txt_node("\\end{lstlisting}"),
				txt_node({ "", "" }),
				txt_node("\\end{adjustwidth}"),
				txt_node({ "", "" }),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "incsvg", name = "Include svg image", snippetType = "autosnippet" }, {
		txt_node("\\begin{figure}[ht]"),
		txt_node({ "", "" }),
		txt_node("    \\centering"),
		txt_node({ "", "" }),
		txt_node("    \\includesvg[width=0.7\\columnwidth]{diagrams/"),
		ins_node(1),
		txt_node(".svg}"),
		txt_node({ "", "" }),
		txt_node("    \\caption{"),
		ins_node(2),
		txt_node("}"),
		txt_node({ "", "" }),
		txt_node("    \\label{fig:"),
		rep(1),
		txt_node("}"),
		txt_node({ "", "" }),
		txt_node("\\end{figure}"),
	}),

	-- Columns

	snippet({ trig = "mul", name = "Multicolumns" }, {
		chc_node(1, {
			{
				txt_node("\\begin{multicols}{"),
				ins_node(1, "columns"),
				txt_node("}"),
				txt_node({ "", "" }),
				ins_node(2),
				txt_node({ "", "" }),
				txt_node("\\end{multicols}"),
			},
			{
				txt_node("\\begin{multicols}{"),
				ins_node(1, "columns"),
				txt_node("}["),
				ins_node(2, "preface"),
				txt_node("]"),
				txt_node({ "", "" }),
				ins_node(3),
				txt_node({ "", "" }),
				txt_node("\\end{multicols}"),
			},
			{
				txt_node("\\begin{multicols}{"),
				ins_node(1, "columns"),
				txt_node("}["),
				ins_node(2, "preface"),
				txt_node("]["),
				ins_node(3, "skip"),
				txt_node("]"),
				txt_node({ "", "" }),
				ins_node(4),
				txt_node({ "", "" }),
				txt_node("\\end{multicols}"),
			},
		}),
	}),

	-- List structures

	-- Ordered lists

	snippet({ trig = "rff", name = "Item reference format" }, {
		txt_node(",ref=\\the"),
		ins_node(1, "<...>"),
		txt_node(".\\textnormal{"),
		snippet_node(
			2,
			chc_node(1, {
				{
					ins_node(1, "\\arabic*"),
					txt_node("}"),
				},
				{
					ins_node(1, "\\Roman*"),
					txt_node("}"),
				},
				{
					ins_node(1, "\\roman*"),
					txt_node("}"),
				},
				{
					ins_node(1, "\\Alph*"),
					txt_node("}"),
				},
				{
					ins_node(1, "\\alph*"),
					txt_node("}"),
				},
			})
		),
	}),

	snippet({ trig = "tz", name = "Unnumbered list" }, {
		txt_node("\\begin{itemize}"),
		txt_node({ "", "" }),
		txt_node("\\item "),
		ins_node(1),
		txt_node({ "", "" }),
		txt_node("\\end{itemize}"),
	}),

	snippet({ trig = "enn", name = "Enumerated list" }, {
		txt_node("\\begin{enumerate}[label=\\textnormal{(\\arabic*)}]"),
		txt_node({ "", "" }),
		txt_node("\\item "),
		ins_node(1),
		txt_node({ "", "" }),
		txt_node("\\end{enumerate}"),
	}),

	snippet({ trig = "enI", name = "Capital roman enumerated list" }, {
		txt_node("\\begin{enumerate}[label=\\textnormal{(\\Roman*)}]"),
		txt_node({ "", "" }),
		txt_node("\\item "),
		ins_node(1),
		txt_node({ "", "" }),
		txt_node("\\end{enumerate}"),
	}),

	snippet({ trig = "eni", name = "Lowercase roman enumerated list" }, {
		txt_node("\\begin{enumerate}[label=\\textnormal{(\\roman*)}]"),
		txt_node({ "", "" }),
		txt_node("\\item "),
		ins_node(1),
		txt_node({ "", "" }),
		txt_node("\\end{enumerate}"),
	}),

	snippet({ trig = "enA", name = "Capital latin enumerated list" }, {
		txt_node("\\begin{enumerate}[label=\\textnormal{(\\Alph*)}]"),
		txt_node({ "", "" }),
		txt_node("\\item "),
		ins_node(1),
		txt_node({ "", "" }),
		txt_node("\\end{enumerate}"),
	}),

	snippet({ trig = "ena", name = "Lowercase latin enumerated list" }, {
		txt_node("\\begin{enumerate}[label=\\textnormal{(\\alph*)}]"),
		txt_node({ "", "" }),
		txt_node("\\item "),
		ins_node(1),
		txt_node({ "", "" }),
		txt_node("\\end{enumerate}"),
	}),

	snippet({ trig = "tm", name = "New item" }, {
		txt_node({ "", "" }),
		txt_node("\\item "),
		ins_node(1),
	}),

	-- Theorem-like environments

	snippet({ trig = "oo", name = "New theorem" }, {
		chc_node(1, {
			{
				txt_node("\\begin{theorem}"),
				txt_node({ "", "" }),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{theorem}"),
			},
			{
				txt_node("\\begin{theorem}["),
				ins_node(1, "name"),
				txt_node("]"),
				txt_node({ "", "" }),
				dyn_node(2, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{theorem}"),
			},
		}),
	}),

	snippet({ trig = "pf", name = "Proof environment" }, {
		chc_node(1, {
			{
				txt_node("\\begin{proof}"),
				txt_node({ "", "" }),
				ins_node(1),
				txt_node({ "", "" }),
				txt_node("\\end{proof}"),
			},
			{
				txt_node("\\begin{proof}["),
				ins_node(1, "name"),
				txt_node("]"),
				txt_node({ "", "" }),
				ins_node(2),
				txt_node({ "", "" }),
				txt_node("\\end{proof}"),
			},
		}),
	}),

	snippet({ trig = "ps", name = "New proposition" }, {
		chc_node(1, {
			{
				txt_node("\\begin{proposition}"),
				txt_node({ "", "" }),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{proposition}"),
			},
			{
				txt_node("\\begin{proposition}["),
				ins_node(1, "name"),
				txt_node("]"),
				txt_node({ "", "" }),
				dyn_node(2, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{proposition}"),
			},
		}),
	}),

	snippet({ trig = "cc", name = "New corollary" }, {
		chc_node(1, {
			{
				txt_node("\\begin{corollary}"),
				txt_node({ "", "" }),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{corollary}"),
			},
			{
				txt_node("\\begin{corollary}["),
				ins_node(1, "name"),
				txt_node("]"),
				txt_node({ "", "" }),
				dyn_node(2, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{corollary}"),
			},
		}),
	}),

	snippet({ trig = "ll", name = "New lemma" }, {
		chc_node(1, {
			{
				txt_node("\\begin{lemma}"),
				txt_node({ "", "" }),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{lemma}"),
			},
			{
				txt_node("\\begin{lemma}["),
				ins_node(1, "name"),
				txt_node("]"),
				txt_node({ "", "" }),
				dyn_node(2, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{lemma}"),
			},
		}),
	}),

	snippet({ trig = "dd", name = "New definition" }, {
		chc_node(1, {
			{
				txt_node("\\begin{definition}"),
				txt_node({ "", "" }),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{definition}"),
			},
			{
				txt_node("\\begin{definition}["),
				ins_node(1, "name"),
				txt_node("]"),
				txt_node({ "", "" }),
				dyn_node(2, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{definition}"),
			},
		}),
	}),

	snippet({ trig = "re", name = "New remark" }, {
		chc_node(1, {
			{
				txt_node("\\begin{remark}"),
				txt_node({ "", "" }),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{remark}"),
			},
			{
				txt_node("\\begin{remark}["),
				ins_node(1, "name"),
				txt_node("]"),
				txt_node({ "", "" }),
				dyn_node(2, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{remark}"),
			},
		}),
	}),

	snippet({ trig = "ex", name = "New exercise" }, {
		chc_node(1, {
			{
				txt_node("\\begin{exercise}"),
				txt_node({ "", "" }),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{exercise}"),
			},
			{
				txt_node("\\begin{exercise}["),
				ins_node(1, "name"),
				txt_node("]"),
				txt_node({ "", "" }),
				dyn_node(2, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{exercise}"),
			},
		}),
	}),

	snippet({ trig = "ee", name = "New example" }, {
		chc_node(1, {
			{
				txt_node("\\begin{example}"),
				txt_node({ "", "" }),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{example}"),
			},
			{
				txt_node("\\begin{example}["),
				ins_node(1, "name"),
				txt_node("]"),
				txt_node({ "", "" }),
				dyn_node(2, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{example}"),
			},
		}),
	}),

	snippet({ trig = "pn", name = "New principle" }, {
		chc_node(1, {
			{
				txt_node("\\begin{principle}"),
				txt_node({ "", "" }),
				dyn_node(1, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{principle}"),
			},
			{
				txt_node("\\begin{principle}["),
				ins_node(1, "name"),
				txt_node("]"),
				txt_node({ "", "" }),
				dyn_node(2, get_visual),
				txt_node({ "", "" }),
				txt_node("\\end{principle}"),
			},
		}),
	}),
}
