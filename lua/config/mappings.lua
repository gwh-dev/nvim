local map, g = vim.keymap.set, vim.g
-- Leader/local leader
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

local expr = { expr = true, noremap = false, silent = false }
map("n", "j", "(v:count ? 'j' : 'gj')", expr)
map("n", "k", "(v:count ? 'k' : 'gk')", expr)
map("", "<Down>", "(v:count ? 'j' : 'gj')", expr)
map("", "<Up>", "(v:count ? 'k' : 'gk')", expr)

-- better navigation betwean panes
local remap = { remap = true, silent = true }
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
-- Move selected line / block of text in visual mode
-- map("x", "K", ":move '<-2<CR>gv-gv")
-- map("x", "J", ":move '>+1<CR>gv-gv")

local nowait = { nowait = true, silent = true }
map("n", "<leader>h", "<cmd>noh<CR>", nowait)
-- terminal
map("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", nowait)
map("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], nowait)
-- Telescope
map("n", "<leader>fi", [[<cmd>Telescope find_files<CR>]], nowait)
map("n", "<leader>l", [[<cmd>Telescope live_grep<CR>]], nowait)
map("n", "<leader>d", [[<cmd>Telescope diagnostics<CR>]], nowait)
map("n", "<leader>b", [[<cmd>Telescope buffers<CR>]], nowait)

-- packer
map("n", "<localleader>s", [[<cmd>Sync<cr>]], nowait)
map("n", "<localleader>i", [[<cmd>Install<cr>]], nowait)
map("n", "<localleader>t", [[<cmd>Status<cr>]], nowait)
map("n", "<localleader>u", [[<cmd>Update<cr>]], nowait)
map("n", "<localleader>c", [[<cmd>Clean<cr>]], nowait)
map("n", "<localleader>m", [[<cmd>Compile<cr>]], nowait)

-- Delete buffers
map("n", "<localleader>d", [[<cmd>BufDel<cr>]], nowait)
