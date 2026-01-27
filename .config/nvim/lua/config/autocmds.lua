-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_user_command("MarkviewReload", function()
  -- 1. Svuota la cache di tutti i moduli che iniziano con 'markview'
  for name, _ in pairs(package.loaded) do
    if name:match("^markview") then
      package.loaded[name] = nil
    end
  end

  -- 2. Ricarica il plugin (riesegui il setup se necessario, o lascia che il plugin si riattivi)
  -- require("markview").setup() -- Decommenta se hai bisogno di ri-passare la config

  -- 3. Ricarica il buffer corrente per forzare il rendering
  vim.cmd("edit!")
  print("Markview ricaricato!")
end, {})

-- Force load MiniZinc syntax via direct source
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zinc",
  callback = function(args)
    vim.treesitter.stop(args.buf)

    local syntax_file = vim.fn.stdpath("config") .. "/lua/syntax/zinc.vim"

    vim.cmd("source " .. syntax_file)
  end,
})
