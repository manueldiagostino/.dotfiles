return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      texlab = {
        disabled = true,
      },
      latexindent = {
        disabled = true,
      },
    },
    formatters_by_ft = {
      tex = { "tex-fmt" },
      latex = { "tex-fmt" },
    },
    default_format_opts = {
      lsp_format = "never",
    },
  },
}
