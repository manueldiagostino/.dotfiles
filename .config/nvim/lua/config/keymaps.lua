--[[

  File di configurazione per le keymap personalizzate in LazyVim.
  Questo file unifica e migliora le scorciatoie per una maggiore
  coerenza e compatibilità con la tastiera italiana.

--]]

-- Funzione helper per creare le keymap in modo più conciso
local map = vim.keymap.set

------------------------------------------------------------------
-- SEZIONE: NAVIGAZIONE ESSENZIALE
------------------------------------------------------------------

-- Movimento su/giù più intelligente (segue le linee wrappate)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down (Smart)" })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up (Smart)" })

------------------------------------------------------------------
-- SEZIONE: GESTIONE FINESTRE E BUFFER
------------------------------------------------------------------

-- Spostarsi tra le finestre con Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Ridimensionare le finestre con Ctrl + Frecce
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Navigazione tra i buffer
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

------------------------------------------------------------------
-- SEZIONE: EDITING DEL TESTO
------------------------------------------------------------------

-- Spostare linee/blocchi di testo con Alt + j/k
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Line Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Selection Up" })

-- Indentazione migliore in modalità visuale
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- Aggiungere punti di undo
map("i", ",", ",<c-g>u", { desc = "Add Undo Point" })
map("i", ".", ".<c-g>u", { desc = "Add Undo Point" })
map("i", ";", ";<c-g>u", { desc = "Add Undo Point" })

------------------------------------------------------------------
-- SEZIONE: TERMINALE A COMPARSA
------------------------------------------------------------------

-- Apri il terminale con <C-t> in modalità normale
map("n", "<C-t>", function()
  Snacks.terminal(nil, { cwd = require("lazyvim.util").root() })
end, { desc = "Terminal (Root Dir)" })

-- Chiudi il terminale con <C-t> dalla modalità terminale
map("t", "<C-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })

------------------------------------------------------------------
-- SEZIONE: PLUGIN E FUNZIONALITÀ EXTRA
------------------------------------------------------------------

-- Salva file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- LuaSnip: navigazione tra gli snippet
local ls = require("luasnip")
map({ "i", "s" }, "<C-L>", function()
  ls.jump(1)
end, { silent = true, desc = "Snippet Jump Forward" })
map({ "i", "s" }, "<C-J>", function()
  ls.jump(-1)
end, { silent = true, desc = "Snippet Jump Backward" })
map({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true, desc = "Snippet Change Choice" })

-- Quickfix list
map("n", "<leader>xq", function()
  local qf_exists = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.fn.getwininfo(win)[1].quickfix == 1 then
      qf_exists = true
      break
    end
  end
  if qf_exists then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { desc = "Toggle Quickfix List" })

map("n", "[q", "<cmd>cprevious<cr>", { desc = "Previous Quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next Quickfix" })

vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", {})
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", {})
