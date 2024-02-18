return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "clangd",
        "jdtls",
        "texlab",
        "pyre",
        "marksman",
      },
    },
  },
}
