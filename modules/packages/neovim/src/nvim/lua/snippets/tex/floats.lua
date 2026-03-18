local ls = require("luasnip")
local snippet = ls.snippet
local txt_node = ls.text_node
local ins_node = ls.insert_node
local chc_node = ls.choice_node

return {

-- Tabular material

	snippet({ trig = "tab", name = "Table environment" }, {
		txt_node("\\begin{table}["),
		ins_node(1, "opt"),
		txt_node("]"),
		txt_node({ "", "" }),
		txt_node("\\begin{tabular}{"),
		ins_node(2, "cols"),
		txt_node("}"),
		txt_node({ "", "" }),
		txt_node("    "),
		ins_node(3),
		txt_node({ "", "" }),
		txt_node("\\end{tabular}"),
		txt_node({ "", "" }),
		txt_node("\\end{table}"),
	}),

	snippet({ trig = "rr", name = "Array environment" }, {
		txt_node("\\begin{array}{"),
		ins_node(1, "cols"),
		txt_node("}"),
		txt_node({ "", "" }),
		txt_node("    "),
		ins_node(2),
		txt_node({ "", "" }),
		txt_node("\\end{array}"),
	}),

	snippet({ trig = "he", name = "Break line height" }, {
		txt_node("\\\\["),
		ins_node(1),
		txt_node("]"),
		txt_node({ "", "" }),
	}),

	snippet({ trig = "hyp", name = "Hyphenate text correctly" }, {
		txt_node("\\hspace{0pt}"),
	}),

	snippet({ trig = "bck", name = "Redefine \\\\ last column" }, {
		txt_node("\\arraybackslash"),
	}),

	snippet({ trig = "lt", name = "Align text to left" }, {
		txt_node("\\raggedleft"),
	}),

	snippet({ trig = "cr", name = "Align text to center" }, {
		txt_node("\\centering"),
	}),

	snippet({ trig = "rt", name = "Align text to right" }, {
		txt_node("\\raggedright"),
	}),

	snippet({ trig = "hn", name = "Horizontal line" }, {
		txt_node("\\hline"),
		txt_node({ "", "" }),
	}),

	snippet({ trig = "br", name = "Tabular row break" }, {
		txt_node("\\\\"),
		txt_node({ "", "" }),
		ins_node(1),
	}),

	-- Tabular environment preamble options

	snippet({ trig = "pc", name = "Top column" }, {
		txt_node("p{"),
		ins_node(1, "width"),
		txt_node("}"),
	}),

	snippet({ trig = "cop", name = "num copies of opts" }, {
		txt_node("*{"),
		ins_node(1, "num"),
		txt_node("}{"),
		ins_node(2, "opts"),
		txt_node("}"),
	}),

	snippet({ trig = "mc", name = "Vertically centered column" }, {
		txt_node("m{"),
		ins_node(1, "width"),
		txt_node("}"),
	}),

	snippet({ trig = "bc", name = "Bottom column" }, {
		txt_node("b{"),
		ins_node(1, "width"),
		txt_node("}"),
	}),

	snippet({ trig = "bl", name = "Before column options" }, {
		txt_node(">{"),
		ins_node(1, "decl"),
		txt_node("}"),
	}),

	snippet({ trig = "af", name = "After column options" }, {
		txt_node("<{"),
		ins_node(1, "decl"),
		txt_node("}"),
	}),

	-- Floats

	snippet({ trig = "cpt", name = "Caption" }, {
		chc_node(1, {
			{
				txt_node("\\caption{"),
				ins_node(1, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\caption["),
				ins_node(1, "list-entry"),
				txt_node("]{"),
				ins_node(2, "text"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "cof", name = "Caption of" }, {
		chc_node(1, {
			{
				txt_node("\\captionof{"),
				ins_node(1, "type"),
				txt_node("}{"),
				ins_node(2, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\captionof{"),
				ins_node(1, "type"),
				txt_node("}["),
				ins_node(2, "list-entry"),
				txt_node("]{"),
				ins_node(3, "text"),
				txt_node("}"),
			},
			{
				txt_node("\\captionof*{"),
				ins_node(1, "type"),
				txt_node("}{"),
				ins_node(2, "text"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "sbf", name = "Subfloat" }, {
		chc_node(1, {
			{
				txt_node("\\subfloat{"),
				ins_node(1, "object"),
				txt_node("}"),
			},
			{
				txt_node("\\subfloat["),
				ins_node(1, "caption"),
				txt_node("]{"),
				ins_node(2, "object"),
				txt_node("}"),
			},
			{
				txt_node("\\subfloat["),
				ins_node(1, "list-entry"),
				txt_node("]["),
				ins_node(2, "caption"),
				txt_node("]{"),
				ins_node(3, "object"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "snt", name = "Sub-numbers for tables" }, {
		txt_node("\\begin{subtables}"),
		txt_node({ "", "" }),
		txt_node("    "),
		ins_node(1),
		txt_node({ "", "" }),
		txt_node("\\end{subtables}"),
	}),

	snippet({ trig = "snf", name = "Sub-numbers for figures" }, {
		txt_node("\\begin{subfigures}"),
		txt_node({ "", "" }),
		txt_node("    "),
		ins_node(1),
		txt_node({ "", "" }),
		txt_node("\\end{subfigures}"),
	}),
}
