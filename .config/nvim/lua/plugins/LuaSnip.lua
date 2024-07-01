return {
  "L3MON4D3/LuaSnip",
  -- -- follow latest release.
  version = "v2.*",
  -- -- install jsregexp (optional!).
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/home/manuel/.config/nvim/lua/snippets" } })
  end,
}
