local ls = require("luasnip")
local snippet = ls.snippet
local txt_node = ls.text_node
local ins_node = ls.insert_node
local chc_node = ls.choice_node

return {

	-- Bibliography and citations

	-- Citations

	snippet({ trig = "cst", name = "Citation style" }, {
		txt_node("\\citestyle{"),
		ins_node(1, "..."),
		txt_node("}"),
	}),

	snippet({ trig = "ct", name = "Citation" }, {
		chc_node(1, {
			{
				txt_node("\\cite{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\cite["),
				ins_node(1, "text"),
				txt_node("]{"),
				ins_node(2, "key-list"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "cf", name = "Full citation" }, {
		chc_node(1, {
			{
				txt_node("\\fullcite{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\fullcite["),
				ins_node(1, "post-note"),
				txt_node("]{"),
				ins_node(2, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\fullcite["),
				ins_node(1, "annotator"),
				txt_node("]["),
				ins_node(2, "post-note"),
				txt_node("]{"),
				ins_node(2, "key-list"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "ctn", name = "Cite not cited" }, {
		chc_node(1, {
			{
				txt_node("\\nocite{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
			{
				ins_node(1, "\\nocite{*}"),
			},
		}),
	}),

	snippet({ trig = "tc", name = "Textual citation" }, {
		chc_node(1, {
			{
				txt_node("\\citet{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citet["),
				ins_node(1, "post-note"),
				txt_node("]{"),
				ins_node(2, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citet["),
				ins_node(1, "pre-note"),
				txt_node("]["),
				ins_node(2, "post-note"),
				txt_node("]{"),
				ins_node(3, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citet*{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citet*["),
				ins_node(1, "post-note"),
				txt_node("]{"),
				ins_node(2, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citet*["),
				ins_node(1, "pre-note"),
				txt_node("]["),
				ins_node(2, "post-note"),
				txt_node("]{"),
				ins_node(3, "key-list"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "tnc", name = "No parentheses textual citation" }, {
		chc_node(1, {
			{
				txt_node("\\citealt{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citealt["),
				ins_node(1, "post-note"),
				txt_node("]{"),
				ins_node(2, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citealt["),
				ins_node(1, "pre-note"),
				txt_node("]["),
				ins_node(2, "post-note"),
				txt_node("]{"),
				ins_node(3, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citealt*{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citealt*["),
				ins_node(1, "post-note"),
				txt_node("]{"),
				ins_node(2, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citealt*["),
				ins_node(1, "pre-note"),
				txt_node("]["),
				ins_node(2, "post-note"),
				txt_node("]{"),
				ins_node(3, "key-list"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "tpc", name = "Parenthetical citation" }, {
		chc_node(1, {
			{
				txt_node("\\citep{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citep["),
				ins_node(1, "post-note"),
				txt_node("]{"),
				ins_node(2, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citep["),
				ins_node(1, "pre-note"),
				txt_node("]["),
				ins_node(2, "post-note"),
				txt_node("]{"),
				ins_node(3, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citep*{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citep*["),
				ins_node(1, "post-note"),
				txt_node("]{"),
				ins_node(2, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citep*["),
				ins_node(1, "pre-note"),
				txt_node("]["),
				ins_node(2, "post-note"),
				txt_node("]{"),
				ins_node(3, "key-list"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "auc", name = "Author citation" }, {
		chc_node(1, {
			{
				txt_node("\\citeauthor{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citeauthor*{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
		}),
	}),

	snippet({ trig = "yec", name = "Year citation" }, {
		chc_node(1, {
			{
				txt_node("\\cityear{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
			{
				txt_node("\\citeyearpar{"),
				ins_node(1, "key-list"),
				txt_node("}"),
			},
		}),
	}),

	-- Bibliography

	snippet({ trig = "bib", name = "Bibliography files" }, {
		txt_node("\\bibliography{"),
		ins_node(1, "file-list"),
		txt_node("}"),
	}),

	snippet({ trig = "bisty", name = "Bibliography style" }, {
		txt_node("\\bibliographystyle{"),
		ins_node(1, "style"),
		txt_node("}"),
	}),
}
