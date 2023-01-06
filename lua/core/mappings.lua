local map = vim.keymap.set

local expr = { expr = true, noremap = false, silent = false }
map("n", "j", "(v:count ? 'j' : 'gj')", expr)
map("n", "k", "(v:count ? 'k' : 'gk')", expr)
map("", "<Down>", "(v:count ? 'j' : 'gj')", expr)
map("", "<Up>", "(v:count ? 'k' : 'gk')", expr)

local remap = { remap = true, silent = true }
-- better navigation betwean panes
map("n", "<C-h>", "<C-w>h", remap)
map("n", "<C-j>", "<C-w>j", remap)
map("n", "<C-k>", "<C-w>k", remap)
map("n", "<C-l>", "<C-w>l", remap)

-- jump betwean lines and center the cursor
map("n", "<C-d>", "<C-d>zz", remap)
map("n", "<C-u>", "<C-u>zz", remap)

-- navigate in hlsearch and center the cursor
map("n", "n", "nzzzv", remap)
map("n", "N", "Nzzzv", remap)

-- Resize with arrows
map("n", "<A-j>", "<cmd>resize -2<CR>")
map("n", "<A-k>", "<cmd>resize +2<CR>")
map("n", "<A-h>", "<cmd>vertical resize -2<CR>")
map("n", "<A-l>", "<cmd>vertical resize +2<CR>")

local silent = { silent = true }
-- Remove highlighting
-- map("n", "<leader>h", "<cmd>noh<CR>", silent)

-- -- Paste and keep yanked before with out changing it
-- map("x", "<leader>p", '"_dP')

-- -- Yank to the clipboard // you need to use space-p
-- map({ "n", "v" }, "<leader>y", "+y")
-- map("n", "<leader>Y", '"+Y')

-- -- Delete with out yanking
-- map({ "n", "v" }, "<leader>d", '"_d')

-- Lazy Command
map("n", "<leader>l", "<cmd>:Lazy<cr>", silent)
