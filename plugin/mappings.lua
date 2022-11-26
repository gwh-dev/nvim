-- Keymaping
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Move around splits using Ctrl + {h,j,k,l}
map("", "<Space>", "<Nop>")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize with arrows
map("n", "<A-k>", [[<cmd>resize -2<cr>]])
map("n", "<A-j>", [[<cmd>resize +2<cr>]])
map("n", "<A-l>", [[<cmd>vertical resize -2<cr>]])
map("n", "<A-h>", [[<cmd>vertical resize +2<cr>]])

-- Yank to clipboard
map("n", "y+", [[<cmd>set opfunc=util#clipboard_yank<cr>g@]])
map("v", "y+", [[<cmd>set opfunc=util#clipboard_yank<cr>g@]])

-- Move betwean buffers
map("n", "<leader>]", [[<cmd>bn<cr>]])
map("n", "<leader>[", [[<cmd>bp<cr>]])

-- Trouble
map("n", "<leader>tt", [[<cmd>TroubleToggle<cr>]])

-- Telescope
map("n", "<leader>gg", [[<cmd>Telescope git_files theme=get_dropdown<cr>]])
map("n", "<leader>ff", [[<cmd>Telescope find_files theme=get_dropdown<cr>]])
map("n", "<leader>ll", [[<cmd>Telescope live_grep theme=get_dropdown<cr>]])
