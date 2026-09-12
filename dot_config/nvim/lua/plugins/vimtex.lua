local wk = require("which-key")

return {
  "lervag/vimtex",
  init = function()
    vim.g["vimtex_view_method"] = "zathura"
    vim.g["vimtex_context_pdf_viewer"] = "okular"
    vim.g["vimtex_log_ignore"] = {
      "Underfull",
      "Overfull",
      "specifier changed to",
      "Token not allowed in a PDF string",
    }
    vim.g["vimtex_quickfix_ignore_filters"] = {
      "Underfull",
      "Overfull",
      "specifier changed to",
      "Token not allowed in a PDF string",
      'Missing "address"',
      'Missing "publisher"',
      'Missing "journal"',
    }
    vim.g.vimtex_root_patterns = { ".latexmkrc", ".git/" }
    vim.g.vimtex_indent_enabled = 0
  end,
  ft = { "tex", "sty" },
}
