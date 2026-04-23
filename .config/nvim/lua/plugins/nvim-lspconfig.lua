return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = { enabled = false },
        vtsls = {
          cmd = {
            "lspmux",
            "client",
            "--server-path",
            "vtsls",
            "--",
            "--stdio",
          },
        },

        eslint = {
          cmd = {
            "lspmux",
            "client",
            "--server-path",
            "vscode-eslint-language-server",
            "--",
            "--stdio",
          },
        },
      },
    },
  },
}
