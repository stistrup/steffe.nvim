vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj"} )

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- incrament/decrament numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Incrament number" }) -- incrament
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrament number" }) -- decrament

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split equal width 
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tap 
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab 
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })--  new tap
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) -- open new tap 
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) -- open new tap 
