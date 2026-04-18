local wk = require("which-key")

return {
  "lervag/vimtex",
  init = function()
    vim.g["vimtex_view_method"] = "zathura_simple"
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
    }

    -- Dice a VimTeX di identificare la radice di un progetto cercando un file .latexmkrc o una cartella .git
    vim.g.vimtex_root_patterns = { ".latexmkrc", ".git/" }

    -- -- Usa XeLaTeX come motore di compilazione
    -- vim.g["vimtex_compiler_latexmk"] = {
    --   executable = "latexmk",
    --   options = {
    --     "-lualatex",
    --     "-file-line-error",
    --     "-synctex=1",
    --     "-interaction=nonstopmode",
    --   },
    -- }
  end,
  ft = { "tex", "sty" },
}
