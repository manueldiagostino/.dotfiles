return {
  "stevearc/conform.nvim",
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      typescript = { "eslint_d", stop_after_first = true },
    },
  },
}
