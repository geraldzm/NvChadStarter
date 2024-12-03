require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Delete selected instances
map("v", "<space>d", "y:%s#\\V<C-r>\"##g<CR>", { desc = "Delete all instances" })
map("v", "<space>D", "y:%s#\\V<C-r>\"##gc<CR>", { desc = "Delete all instances with confirmation" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
