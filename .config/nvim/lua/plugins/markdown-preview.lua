local wk = require("which-key")

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,

  wk.register({
    ["<leader>"] = {
      m = {
        name = "+MarkdownPreview", --- group name
        m = { "<cmd>MarkdownPreview<cr>", desc = "MarkdownPreview" },
        s = { "<cmd>MarkdownPreviewStop<cr>", desc = "MarkdownPreviewStop" },
        t = { "<cmd>MarkdownPreviewToggle<cr>", desc = "MarkdownPreviewToggle" },
      },
    },
  }),
  keys = {
    { "<leader>mm", "<cmd>MarkdownPreview<cr>", desc = "MarkdownPreview" },
    { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "MarkdownPreviewStop" },
    { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "MarkdownPreviewToggle" },
  },
}
