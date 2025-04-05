--[[ Keymappings ]]--

local ntst = { noremap=true, silent=true }

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- Easy split navigation

vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap=true, silent=true })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap=true, silent=true })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap=true, silent=true })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap=true, silent=true })

vim.keymap.set("n", "<C-Down>",  "<C-W><C-J>", { noremap=true, silent=true })
vim.keymap.set("n", "<C-Up>",    "<C-W><C-K>", { noremap=true, silent=true })
vim.keymap.set("n", "<C-Right>", "<C-W><C-L>", { noremap=true, silent=true })
vim.keymap.set("n", "<C-Left>",  "<C-W><C-H>", { noremap=true, silent=true })

-- code folding shurtcut
vim.keymap.set("n", "<leader><space>", "za", { noremap=true, silent=true })

-- Highlighting desable shortcut
vim.keymap.set("n", "<leader>n", ":noh<CR>", { noremap=true, silent=true })

-- Centring the cursure on page up/down
vim.keymap.set("n", "<C-u>", "<C-u>zz", ntst)
vim.keymap.set("n", "<C-d>", "<C-d>zz", ntst)
vim.keymap.set("n", "<C-b>", "<C-b>zz", ntst)
vim.keymap.set("n", "<C-f>", "<C-f>zz", ntst)

