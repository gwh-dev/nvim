local map = vim.keymap.set

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move down" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move up" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move up" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move up" })

-- jump betwean lines and center the cursor
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Create a new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- highlights under cursor
map("n", "<leader>hl", vim.show_pos, { desc = "Highlight Groups at cursor" }) -- for neovim >= 0.9.0

-- Change tmux session
-- map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", remap)

-- Remove highlighting
-- map("n", "n", "nzzzv", remap)  -- old
-- map("n", "N", "Nzzzv", remap)  -- old
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- highlight all the same ones
map({ "n", "x" }, "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Package Manager
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- Buffer delete and quit
map("n", "<localleader>q", function()
    if vim.bo.filetype == "neo-tree" then
        require("neo-tree").close_all()
    else
        return vim.cmd "BufDel"
    end
end, { desc = "Delete Buffer And Quit" })

-- buffers
map("n", "]b", "<cmd>:BufferLineCycleNext<CR>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>:BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
map("n", "<leader>`", "<cmd>:e #<cr>", { desc = "Switch to Other Buffer" })
