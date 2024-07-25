local wk = require("which-key")

return {
  "iamcco/markdown-preview.nvim",
  lazy = true,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,

  wk.add({
    { "<leader>m", group = "MarkdownPreview", icon = "" },
    { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "MarkdownPreviewStop", icon = "" },
    { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "MarkdownPreviewToggle", icon = "" },
    { "<leader>mv", "<cmd>MarkdownPreview<cr>", desc = "MarkdownPreview", icon = "" },
  }),
}
