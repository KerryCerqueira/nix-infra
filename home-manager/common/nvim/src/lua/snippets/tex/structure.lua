local ls = require("luasnip")
local snippet = ls.snippet
local snippet_node = ls.snippet_node
local txt_node = ls.text_node
local ins_node = ls.insert_node
local fn_node = ls.function_node
local chc_node = ls.choice_node
local dyn_node = ls.dynamic_node

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

	-- Document preamble

	snippet({ trig = "doc", name = "Document class" }, {
		chc_node(1, {
			{
				txt_node("\\documentclass{"),
				ins_node(1, "document-class"),
				txt_node("}"),
			},
			{
				txt_node("\\documentclass["),
				ins_node(1, "class-options"),
				txt_node("]{"),
				ins_node(2, "document-class"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "pk", name = "Use package" }, {
		chc_node(1, {
			{
				txt_node("\\usepackage{"),
				ins_node(1, "package-name"),
				txt_node("}"),
			},
			{
				txt_node("\\usepackage["),
				ins_node(1, "package-options"),
				txt_node("]{"),
				ins_node(2, "package-name"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "tl", name = "Title" }, {
		txt_node("\\title{"),
		ins_node(1, "..."),
		txt_node("}"),
	}),

	snippet({ trig = "dat", name = "Date" }, {
		txt_node("\\date{"),
		ins_node(1, "..."),
		txt_node("}"),
	}),

	snippet({ trig = "aut", name = "Author" }, {
		txt_node("\\author{"),
		ins_node(1, "..."),
		txt_node("}"),
	}),

	snippet({ trig = "td", name = "Today's date" }, {
		txt_node("\\today"),
	}),

	snippet({ trig = "bd", name = "Begin document" }, {
		txt_node("\\begin{document}"),
		txt_node({ "", "" }),
		txt_node({ "", "" }),
		ins_node(1),
		txt_node({ "", "" }),
		txt_node({ "", "" }),
		txt_node("\\end{document}"),
	}),

	-- Sectioning

	snippet({ trig = "scn", name = "Section" }, {
		chc_node(1, {
			{
				txt_node("\\section{"),
				v(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\section*{"),
				v(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\section["),
				ins_node(1, "toc-entry"),
				txt_node("]{"),
				v(2, "title"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "sbn", name = "Subection" }, {
		chc_node(1, {
			{
				txt_node("\\subsection{"),
				v(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\subsection*{"),
				v(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\subsection["),
				ins_node(1, "toc-entry"),
				txt_node("]{"),
				v(2, "title"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "ssn", name = "Subsubection" }, {
		chc_node(1, {
			{
				txt_node("\\subsubsection{"),
				v(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\subsubsection*{"),
				v(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\subsubsection["),
				ins_node(1, "toc-entry"),
				txt_node("]{"),
				v(2, "title"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "chr", name = "Chapter" }, {
		chc_node(1, {
			{
				txt_node("\\chapter{"),
				v(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\chapter*{"),
				v(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\chapter["),
				ins_node(1, "toc-entry"),
				txt_node("]{"),
				v(2, "title"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "prt", name = "Part" }, {
		chc_node(1, {
			{
				txt_node("\\part{"),
				ins_node(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\part*{"),
				ins_node(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\part["),
				ins_node(1, "toc-entry"),
				txt_node("]{"),
				v(2, "title"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "pr", name = "Paragraph" }, {
		chc_node(1, {
			{
				txt_node("\\paragraph{"),
				ins_node(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\paragraph*{"),
				ins_node(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\paragraph["),
				ins_node(1, "toc-entry"),
				txt_node("]{"),
				v(2, "title"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "sbp", name = "Subaragraph" }, {
		chc_node(1, {
			{
				txt_node("\\subparagraph{"),
				ins_node(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\subparagraph*{"),
				ins_node(1, "title"),
				txt_node("}"),
			},
			{
				txt_node("\\subparagraph["),
				ins_node(1, "toc-entry"),
				txt_node("]{"),
				v(2, "title"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "phs", name = "Hyperref jump to correct page" }, {
		txt_node("\\phantomsection"),
	}),

	snippet({ trig = "add", name = "Add entry to list" }, {
		txt_node("\\addcontentsline{"),
		ins_node(1, "file"),
		txt_node("}{"),
		ins_node(2, "sec-unit"),
		txt_node("}{"),
		ins_node(3, "list-entry"),
		txt_node("}"),
	}),

	snippet({ trig = "mkb", name = "Headers in twoside mode" }, {
		txt_node("\\markboth{"),
		ins_node(1, "left"),
		txt_node("}{"),
		ins_node(2, "right"),
		txt_node("}"),
	}),

	snippet({ trig = "mkt", name = "Maketitle" }, {
		txt_node("\\maketitle"),
	}),

	snippet({ trig = "toc", name = "Table of contents" }, {
		txt_node("\\tableofcontents"),
	}),

	snippet({ trig = "lot", name = "List of tables" }, {
		txt_node("\\listoftables"),
	}),

	snippet({ trig = "lof", name = "List of figures" }, {
		txt_node("\\listoffigures"),
	}),

	snippet({ trig = "mki", name = "Makeindex" }, {
		txt_node("\\makeindex"),
	}),

	snippet({ trig = "pix", name = "Print index" }, {
		txt_node("\\printindex"),
	}),

	snippet({ trig = "pdf", name = "PDF bookmark" }, {
		txt_node("\\texorpdfstring{"),
		v(1, "tex"),
		txt_node("}{"),
		ins_node(2, "bookmark"),
		txt_node("}"),
	}),

	snippet({ trig = "lec", name = "Lecture section" }, {
		txt_node("%%% "),
		ins_node(1, "title"),
		txt_node({ "", "" }),
		txt_node("\\seclecture{"),
		ins_node(2, "title"),
		txt_node("}{"),
		ins_node(3, "date"),
		txt_node("}"),
	}),

	snippet({ trig = "les", name = "Lecture subsection" }, {
		txt_node("%%% "),
		ins_node(1, "title"),
		txt_node({ "", "" }),
		txt_node("\\sublecture{"),
		ins_node(2, "title"),
		txt_node("}{"),
		ins_node(3, "date"),
		txt_node("}"),
	}),

	snippet({ trig = "date", name = "Print current date" }, {
		fn_node(function()
			return os.date("%a %d %b %y")
		end),
	}),

	snippet({ trig = "tim", name = "Margin paragraph timestamp" }, {
		txt_node("\\marginpar{\\footnotesize\\textsf{\\mbox{"),
		ins_node(1, "date"),
		txt_node("}}}"),
	}),

	-- Cross-references

	-- Labels

	snippet({ trig = "lge", name = "Generic label" }, {
		txt_node("\\label{"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lsn", name = "Label section" }, {
		txt_node("\\label{sec:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lsb", name = "Label subsection" }, {
		txt_node("\\label{sub:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lss", name = "Label subsubsection" }, {
		txt_node("\\label{ssub:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lch", name = "Label chapter" }, {
		txt_node("\\label{ch:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lpa", name = "Label paragraph" }, {
		txt_node("\\label{par:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lsp", name = "Label subparagraph" }, {
		txt_node("\\label{subpar:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lbe", name = "Label equation" }, {
		txt_node("\\label{eq:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lbt", name = "Label theorem" }, {
		txt_node("\\label{thm:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lps", name = "Label proposition" }, {
		txt_node("\\label{prop:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lle", name = "Label lemma" }, {
		txt_node("\\label{lem:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lco", name = "Label corollary" }, {
		txt_node("\\label{cor:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lde", name = "Label definition" }, {
		txt_node("\\label{def:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lre", name = "Label remark" }, {
		txt_node("\\label{rem:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lex", name = "Label exercise" }, {
		txt_node("\\label{ex:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "leg", name = "Label example" }, {
		txt_node("\\label{eg:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lpn", name = "Label principle" }, {
		txt_node("\\label{princ:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lbi", name = "Label item" }, {
		txt_node("\\label{it:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lfg", name = "Label figure" }, {
		txt_node("\\label{fig:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "lta", name = "Label table" }, {
		txt_node("\\label{tbl:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	-- Reference commands

	snippet({ trig = "rge", name = "Generic cross-reference" }, {
		chc_node(1, {
			{
				txt_node("\\ref{"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rsn", name = "Reference section" }, {
		chc_node(1, {
			{
				txt_node("\\ref{sec:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{sec:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{sec:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rsb", name = "Reference subsection" }, {
		chc_node(1, {
			{
				txt_node("\\ref{sub:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{sub:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{sub:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rss", name = "Reference subsubsection" }, {
		chc_node(1, {
			{
				txt_node("\\ref{ssub:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{ssub:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{ssub:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rch", name = "Reference chapter" }, {
		chc_node(1, {
			{
				txt_node("\\ref{ch:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{ch:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{ch:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rpa", name = "Reference paragraph" }, {
		chc_node(1, {
			{
				txt_node("\\ref{par:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{par:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{par:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rsp", name = "Reference subparagraph" }, {
		chc_node(1, {
			{
				txt_node("\\ref{subpar:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{subpar:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{subpar:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rfe", name = "Reference equation" }, {
		chc_node(1, {
			{
				txt_node("\\eqref{eq:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{eq:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{eq:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rft", name = "Reference theorem" }, {
		chc_node(1, {
			{
				txt_node("\\ref{thm:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{thm:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{thm:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rps", name = "Reference proposition" }, {
		chc_node(1, {
			{
				txt_node("\\ref{prop:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{prop:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{prop:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rle", name = "Reference lemma" }, {
		chc_node(1, {
			{
				txt_node("\\ref{lem:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{lem:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{lem:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rco", name = "Reference corollary" }, {
		chc_node(1, {
			{
				txt_node("\\ref{cor:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{cor:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{cor:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rde", name = "Reference definition" }, {
		chc_node(1, {
			{
				txt_node("\\ref{def:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{def:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{def:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rre", name = "Reference remark" }, {
		chc_node(1, {
			{
				txt_node("\\ref{rem:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{rem:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{rem:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rex", name = "Reference exercise" }, {
		chc_node(1, {
			{
				txt_node("\\ref{ex:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{ex:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{ex:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "reg", name = "Reference example" }, {
		chc_node(1, {
			{
				txt_node("\\ref{eg:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{eg:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{eg:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rpn", name = "Reference principle" }, {
		chc_node(1, {
			{
				txt_node("\\ref{princ:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{princ:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{princ:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rfi", name = "Reference item" }, {
		chc_node(1, {
			{
				txt_node("\\ref{it:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{it:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{it:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rfg", name = "Reference figure" }, {
		chc_node(1, {
			{
				txt_node("\\ref{fig:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{fig:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{fig:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "rta", name = "Reference table" }, {
		chc_node(1, {
			{
				txt_node("\\ref{tbl:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\cref{tbl:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
			{
				txt_node("\\Cref{tbl:"),
				ins_node(1, "key"),
				txt_node("}"),
			},
		}),
	}),

	-- Page reference commands

	snippet({ trig = "pge", name = "Generic page reference" }, {
		txt_node("\\pageref{"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "psn", name = "Page of section" }, {
		txt_node("\\pageref{sec:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "psb", name = "Page of subsection" }, {
		txt_node("\\pageref{sub:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "pss", name = "Page of subsubsection" }, {
		txt_node("\\pageref{ssub:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "pch", name = "Page of chapter" }, {
		txt_node("\\pageref{ch:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "ppa", name = "Page of paragraph" }, {
		txt_node("\\pageref{par:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "psp", name = "Page of subparagraph" }, {
		txt_node("\\pageref{subpar:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "peq", name = "Page of equation" }, {
		txt_node("\\eqref{eq:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "pgt", name = "Page of theorem" }, {
		txt_node("\\pageref{thm:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "pps", name = "Page of proposition" }, {
		txt_node("\\pageref{prop:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "ple", name = "Page of lemma" }, {
		txt_node("\\pageref{lem:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "pco", name = "Page of corollary" }, {
		txt_node("\\pageref{cor:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "pde", name = "Page of definition" }, {
		txt_node("\\pageref{def:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "pre", name = "Page of remark" }, {
		txt_node("\\pageref{rem:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "pex", name = "Page of exercise" }, {
		txt_node("\\pageref{ex:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "peg", name = "Page of example" }, {
		txt_node("\\pageref{eg:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "ppn", name = "Page of principle" }, {
		txt_node("\\pageref{princ:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "pgi", name = "Page of item" }, {
		txt_node("\\pageref{it:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "pfg", name = "Page of figure" }, {
		txt_node("\\pageref{fig:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),

	snippet({ trig = "pta", name = "Page of table" }, {
		txt_node("\\pageref{tbl:"),
		ins_node(1, "key"),
		txt_node("}"),
	}),
}
