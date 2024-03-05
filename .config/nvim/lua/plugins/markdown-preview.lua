local wk = require("which-key")

return {
  "iamcco/markdown-preview.nvim",
  lazy = true,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,

  wk.register({
    ["<leader>"] = {
      m = {
        name = "+MarkdownPreview", --- group name
        v = { "<cmd>MarkdownPreview<cr>", "MarkdownPreview" },
        s = { "<cmd>MarkdownPreviewStop<cr>", "MarkdownPreviewStop" },
        t = { "<cmd>MarkdownPreviewToggle<cr>", "MarkdownPreviewToggle" },
      },
    },
  }),
}
