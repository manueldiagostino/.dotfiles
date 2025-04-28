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

  wk.add({
    { "<leader>t", group = "VimTeX" },
    { "<leader>ta", "<cmd>:VimtexStopAll<CR>", desc = "stop all VimTeX" },
    { "<leader>tc", "<cmd>VimtexCompile<CR>", desc = "compile" },
    { "<leader>te", "<cmd>VimtexErrors<CR>", desc = "see errors" },
    { "<leader>tr", "<cmd>:VimtexClearCache All<CR>", desc = "reset vimtex" },
    { "<leader>ts", "<cmd>:VimtexStop<CR>", desc = "stop VimTeX" },
    { "<leader>tg", "<cmd>VimtexTocToggle<CR>", desc = "toggle TOC" },
    { "<leader>tt", "<cmd>VimtexTocOpen<CR>", desc = "open TOC" },
    { "<leader>tv", "<cmd>VimtexView<CR>", desc = "view" },
  }),
}
