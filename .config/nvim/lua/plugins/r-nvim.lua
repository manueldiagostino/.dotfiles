return {
  "R-nvim/R.nvim",
  lazy = true,
  ft = "r",
  opts = function(_, opts)
    -- Wrappa l'hook on_filetype per preservare le mappature originali di R.nvim
    -- ma sovrascrivere <Enter> con il comportamento "nuova riga vuota"
    local orig_on_filetype = opts.hook and opts.hook.on_filetype
    opts.hook = opts.hook or {}
    opts.hook.on_filetype = function()
      if orig_on_filetype then
        orig_on_filetype()
      end
      -- Il plugin carica solo per .r quindi qui va applicato sempre
      vim.keymap.set("n", "<Enter>", "o<ESC>", { buffer = true, desc = "Insert Empty Line Below" })
      vim.keymap.set("n", "<S-Enter>", "O<ESC>", { buffer = true, desc = "Insert Empty Line Above" })
    end
  end,
}
