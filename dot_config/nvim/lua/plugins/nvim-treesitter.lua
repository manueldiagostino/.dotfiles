-- ref: https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file

return {
  "nvim-treesitter/nvim-treesitter",

  -- The `opts` function allows you to safely modify the plugin's options
  opts = function(_, opts)
    -- Add `strictdoc` to the `ensure_installed` list
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "strictdoc" })
    end
  end,

  init = function()
    -- Register the filetypes
    -- This tells Neovim to use the 'strictdoc' filetype for .sdoc and .sgra files.
    vim.filetype.add({
      extension = {
        sdoc = "strictdoc",
        sgra = "strictdoc",
      },
    })

    -- Define the custom parser
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").strictdoc = {
          install_info = {
            url = "https://github.com/manueldiagostino/tree-sitter-strictdoc",
            files = { "src/parser.c" },
            queries = "queries",
          },
          filetype = "strictdoc", -- Associate this parser with the 'strictdoc' filetype
        }
      end,
    })
  end,
}
