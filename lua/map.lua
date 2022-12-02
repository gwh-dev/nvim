-- local map = vim.keymap.set
-- Leader/local leader
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]
-- Clear Highlighting until the next search
local expr = { expr = true, noremap = false, silent = false }
vim.keymap.set("n", "j", "(v:count ? 'j' : 'gj')", expr)
vim.keymap.set("n", "k", "(v:count ? 'k' : 'gk')", expr)
vim.keymap.set("", "<Down>", "(v:count ? 'j' : 'gj')", expr)
vim.keymap.set("", "<Up>", "(v:count ? 'k' : 'gk')", expr)

-- Disable hjkl + esc (get used to sneak) + jk and jj
-- vim.keymap.set('i', '<esc>', '<Nop>')
-- vim.keymap.set('n', 'j', '<Nop>')
-- vim.keymap.set('n', 'k', '<Nop>')
-- vim.keymap.set('n', 'h', '<Nop>')
-- vim.keymap.set('n', 'l', '<Nop>')

local remap = { remap = true, silent = true }

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set("n", "<C-h>", "<C-w>h", remap)
vim.keymap.set("n", "<C-j>", "<C-w>j", remap)
vim.keymap.set("n", "<C-k>", "<C-w>k", remap)
vim.keymap.set("n", "<C-l>", "<C-w>l", remap)

-- Resize with arrows
vim.keymap.set("n", "<A-j>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<A-k>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<A-h>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<A-l>", "<cmd>vertical resize +2<CR>")
-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- ctrl + a : select all
vim.keymap.set("n", "<C-a>", "<esc>ggVG<CR>")

-- Move selected line / block of text in visual mode
-- shift + k to move up
-- shift + j to move down
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")

-- Yank to clipboard
vim.keymap.set({ "n", "v", "x" }, "y+", [[<cmd>set opfunc=util#clipboard_yank<cr>g@]], { nowait = true })

-- paste in visual mode and keep available
vim.keymap.set("x", "p", [['pgv"'.v:register.'y`>']], expr)
vim.keymap.set("x", "P", [['Pgv"'.v:register.'y`>']], expr)

-- select last inserted text
vim.keymap.set("n", "gV", [['`[' . strpart(getregtype(), 0, 1) . '`]']], expr)

-- navigate paragraphs without altering jumplist
-- local silent = { silent = true }
-- vim.keymap.set("n", "}", ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>', silent)
-- vim.keymap.set("n", "{", ':<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>', silent)

-- [[ Plugins ]]

local nowait = { nowait = true, silent = true }
-- Trouble
vim.keymap.set("n", "<leader>tt", [[<Cmd>Trouble<cr>]], nowait)
vim.keymap.set("n", "<leader>td", [[<cmd>TodoTrouble<cr>]], nowait)

-- Telescope
vim.keymap.set("n", "<leader>gg", [[<cmd>Telescope git_files theme=get_dropdown<cr>]], nowait)
vim.keymap.set("n", "<leader>ff", "<Cmd>Telescope find_files theme=get_dropdown<cr>", nowait)
vim.keymap.set("n", "<leader>ll", [[<cmd>Telescope live_grep theme=get_dropdown<cr>]], nowait)

-- Version Control "GIT"
vim.keymap.set("n", "<leader>gs", [[<cmd>Neogit<cr>]])

-- Buffers
vim.keymap.set("n", "<leader>db", [[<cmd>BufDel<cr>]], nowait)
