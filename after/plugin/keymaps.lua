-- Keymaping
-- local function map(mode, lhs, rhs, opts)
-- 	local options = { noremap = true, silent = true }
-- 	if opts then
-- 		options = vim.tbl_extend("force", options, opts)
-- 	end
-- 	vim.keymap.set(mode, lhs, rhs, options)
-- end
local map = vim.keymap.set

-- Clear Highlighting until the next search
local expr = { expr = true, noremap = false, silent = false }
map("n", "j", "(v:count ? 'j' : 'gj')", expr)
map("n", "k", "(v:count ? 'k' : 'gk')", expr)
map("", "<Down>", "(v:count ? 'j' : 'gj')", expr)
map("", "<Up>", "(v:count ? 'k' : 'gk')", expr)

map("n", "<leader>h", [[<cmd>noh<cr>]], { silent = true })

-- Disable hjkl + esc (get used to sneak) + jk and jj
map('i', '<esc>', '<Nop>')
map('n', 'j', '<Nop>')
map('n', 'k', '<Nop>')
map('n', 'h', '<Nop>')
map('n', 'l', '<Nop>')

local remap = { remap = true, silent = false }
-- Move around splits using Ctrl + {h,j,k,l}
-- map("", "<Space>", "<Nop>")
map("n", "<C-h>", "<C-w>h", remap)
map("n", "<C-j>", "<C-w>j", remap)
map("n", "<C-k>", "<C-w>k", remap)
map("n", "<C-l>", "<C-w>l", remap)

-- Resize with arrows
map("n", "<A-j>", "<cmd>resize -2<CR>")
map("n", "<A-k>", "<cmd>resize +2<CR>")
map("n", "<A-h>", "<cmd>vertical resize -2<CR>")
map("n", "<A-l>", "<cmd>vertical resize +2<CR>")
-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ctrl + a : select all
map("n", "<C-a>", "<esc>ggVG<CR>")

-- Move selected line / block of text in visual mode
-- shift + k to move up
-- shift + j to move down
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")

-- Yank to clipboard
map({ "n", "v" }, "y+", [[<cmd>set opfunc=util#clipboard_yank<cr>g@]])

-- paste in visual mode and keep available
map("x", "p", [['pgv"'.v:register.'y`>']], expr)
map("x", "P", [['Pgv"'.v:register.'y`>']], expr)

-- select last inserted text
map("n", "gV", [['`[' . strpart(getregtype(), 0, 1) . '`]']], expr)

-- navigate paragraphs without altering jumplist
-- local silent = { silent = true }
-- map("n", "}", ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>', silent)
-- map("n", "{", ':<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>', silent)

-- [[ Plugins ]]
local nowait = { silent = true, nowait = true, noremap = true }
-- Trouble
map("n", "<leader>tt", [[<cmd>TroubleToggle<cr>]], nowait)
map("n", "<leader>td", [[<cmd>TodoTrouble<cr>]], nowait)

-- Telescope
map("n", "<leader>gg", [[<cmd>Telescope git_files theme=get_dropdown<cr>]], nowait)
map("n", "<leader>ff", [[<cmd>Telescope find_files theme=get_dropdown<cr>]], nowait)
map("n", "<leader>ll", [[<cmd>Telescope live_grep theme=get_dropdown<cr>]], nowait)

-- Buffers
map("n", "<leader>d", [[<cmd>BufDel<cr>]], nowait)

-- Version Control
-- map("n", "gs", [[<cmd>Neogit<cr>]])
