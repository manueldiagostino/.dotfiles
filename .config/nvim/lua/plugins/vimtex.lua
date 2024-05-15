local wk = require("which-key")

return {
  "lervag/vimtex",
  vimtex_syntax_enabled = 0,
  init = function()
    -- vim.g["vimtex_view_method"] = "zathura" -- main variant with xdotool (requires X11; not compatible with wayland)
    vim.g["vimtex_view_method"] = "zathura_simple" -- for variant without xdotool to avoid errors in wayland
    vim.g["vimtex_quickfix_mode"] = 0 -- suppress error reporting on save and build
    vim.g["vimtex_syntax_enabled"] = 0
    vim.g["vimtex_mappings_enabled"] = 0 -- Ignore mappings
    vim.g["vimtex_indent_enabled"] = 0 -- Auto Indent
    vim.g["tex_flavor"] = "latex" -- how to read tex files
    vim.g["tex_indent_items"] = 0 -- turn off enumerate indent
    vim.g["tex_indent_brace"] = 0 -- turn off brace indent
    vim.g["vimtex_context_pdf_viewer"] = "okular" -- external PDF viewer run from vimtex menu command
    vim.g["vimtex_log_ignore"] = { -- Error suppression:
      "Underfull",
      "Overfull",
      "specifier changed to",
      "Token not allowed in a PDF string",
    }
    -- vim.g["vimtex_view_general_viewer"] = "okular"
    -- vim.g["vimtex_compiler_method"] = "latexrun"
    -- vim.g["vimtex_view_general_options"] = "--unique file:@pdf#src:@line@tex"
  end,

  wk.register({
    ["<leader>"] = {
      t = {
        name = "+VimTeX", --- group name
        c = { "<cmd>VimtexCompile<CR>", "compile" },
        e = { "<cmd>VimtexErrors<CR>", "see errors" },
        t = { "<cmd>VimtexTocOpen<CR>", "open TOC" },
        g = { "<cmd>VimtexTocOpen<CR>", "toggle TOC" },
        v = { "<cmd>VimtexView<CR>", "view" },
        r = { "<cmd>:VimtexClearCache All<CR>", "reset vimtex" },
        s = { "<cmd>:VimtexStop<CR>", "stop VimTeX" },
        a = { "<cmd>:VimtexStopAll<CR>", "stop all VimTeX" },
      },
    },
  }),
}
