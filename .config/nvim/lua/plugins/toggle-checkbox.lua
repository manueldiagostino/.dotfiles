local wk = require("which-key")

return {
  "nfrid/markdown-togglecheck",
  dependencies = { "nfrid/treesitter-utils" },
  ft = { "markdown" },
  wk.add({
    { "<leader>nn", ":lua require('markdown-togglecheck').toggle()<CR>", desc = "Toggle Markdown checkmark" },
    { "<leader>nN", ":lua require('markdown-togglecheck').toggle_box()<CR>", desc = "Toggle Markdown checkbox" },
  }),
}
