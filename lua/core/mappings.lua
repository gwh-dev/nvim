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

local nowait = { nowait = true, silent = true }
map("n", "<leader>h", "<cmd>noh<CR>", nowait)

-- Telescope
map("n", "<leader>d", [[<cmd>Telescope diagnostics theme=get_ivy<CR>]], nowait)
map("n", "<leader>b", [[<cmd>Telescope buffers theme=get_ivy<CR>]], nowait)
map("n", "<leader>F", [[<cmd>Telescope find_files theme=get_dropdown<CR>]], nowait)
map("n", "<leader>l", [[<cmd>Telescope live_grep theme=get_dropdown<CR>]], nowait)
map("n", "<leader>r", "<cmd>Telescope frecency theme=get_dropdown<CR>", nowait)

-- SymbolOutline
map("n", "<leader>o", [[<cmd>SymbolsOutline<CR>]], nowait)

-- packer
map("n", "<localleader>s", [[<cmd>PackerSync<cr>]], nowait)
map("n", "<localleader>i", [[<cmd>PackerInstall<cr>]], nowait)
map("n", "<localleader>S", [[<cmd>PackerStatus<cr>]], nowait)
map("n", "<localleader>u", [[<cmd>PackerUpdate<cr>]], nowait)
-- map("n", "<localleader>c", [[<cmd>PackerClean<cr>]], nowait)
-- map("n", "<localleader>C", [[<cmd>PackerCompile<cr>]], nowait)

-- Delete buffers
map("n", "<localleader>q", [[<cmd>BufDel<cr>]], nowait)
