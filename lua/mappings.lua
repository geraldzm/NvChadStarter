require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Delete selected instances
map("v", "<space>d", "y:%s#\\V<C-r>\"##g<CR>", { desc = "Delete all instances" })
map("v", "<space>D", "y:%s#\\V<C-r>\"##gc<CR>", { desc = "Delete all instances with confirmation" })
-- Replace selected instances with custom text
map("v", "<space>r", "y:%s#\\V<C-r>\"##g<left><left>", { desc = "Replace all instances (type replacement)" })
map("v", "<space>R", "y:%s#\\V<C-r>\"##gc<left><left>", { desc = "Replace all instances (type replacement)" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
