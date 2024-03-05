local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)
keymap("v", "d", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Markdown Preview
keymap("i", "<C-s>", "<C-o>:MarkdownPreview<CR>", opts)
keymap("i", "<M-s>", "<C-o>:MarkdownPreviewStop<CR>", opts)
keymap("i", "<C-p>", "<C-o>:MarkdownPreviewToggle<CR>", opts)

-- lvim.keys.normal_mode["<C-s>"] = ":MarkdownPreview<CR>"
