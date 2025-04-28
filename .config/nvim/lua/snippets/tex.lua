local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

local rep = require("luasnip.extras").rep

luasnip.add_snippets("tex", {
  s("coursemeta", {
    t({
      "\\documentclass{article}",
      "\\usepackage{../../csnotes}",
      "",
      "\\renewcommand{\\coursetitle}{",
    }),
    i(1, "Corso ..."),
    t({
      "}",
      "",
      "\\renewcommand{\\coursecode}{",
    }),
    i(2, "000"),
    t({
      "}",
      "\\begin{document}",
      "\\maketitle",
      "",
    }),
    i(0),
    t({
      "",
      "\\end{document}",
    }),
  }),
})

luasnip.add_snippets("tex", {
  s("beg", {
    t("\\begin{"),
    i(1, "environment"),
    t("}"),
    t({ "", "\t" }),
    i(2),
    t({ "", "\\end{" }),
    rep(1),
    t("}"), -- 🔥 `rep(1)` ripete il valore di `i(1)`
  }),
})

luasnip.add_snippets("tex", {
  s("header", {
    t({
      "\\documentclass{article}",
      "",
      "\\usepackage[T1]{fontenc}",
      "\\usepackage[utf8]{inputenc}",
      "\\usepackage{lmodern}",
      "",
      "\\usepackage{amsmath}",
      "\\usepackage{amssymb}",
      "\\usepackage{amsfonts}",
      "",
      "\\usepackage{graphicx}",
      "\\usepackage{xcolor}",
      "",
      "\\title{",
    }),
    i(1, "Document Title"),
    t("}"),
    t({
      "",
      "\\author{",
    }),
    i(2, "Author Name"),
    t("}"),
    t({
      "",
      "\\date{",
    }),
    i(3, "\\today"),
    t("}"),
    t({
      "",
      "\\begin{document}",
      "",
    }),
    t("\\maketitle"),
    t({
      "",
      "",
    }),
    i(4, "Your text here"),
    t({
      "",
      "\\end{document}",
    }),
  }),
})
