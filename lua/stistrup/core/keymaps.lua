vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj"} )

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
