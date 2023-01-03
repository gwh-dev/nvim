local opt = vim.opt
local g = vim.g

g.mapleader = [[ ]]
g.maplocalleader = [[,]]

g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

-- opt.list = true
-- opt.listchars:append({
-- 	-- tab = "❘-",
-- 	-- trail = "·",
-- 	-- lead = "·",
-- 	extends = "»",
-- 	precedes = "«",
-- 	nbsp = "×",
-- 	-- eol = "↴",
-- })
opt.termguicolors = true
vim.opt.foldenable = false
opt.swapfile = false
opt.backup = false
opt.undodir = "/home/gwh/.vim/undodir"
opt.wrap = false
opt.undofile = true
opt.wildmode = "longest:full,full"
opt.wildignorecase = true
opt.ignorecase = true
opt.completeopt = { "menu", "menuone", "noselect" }
-- opt.scrolloff = 8
-- opt.lazyredraw = true
opt.showmatch = true
opt.ignorecase = true
opt.hlsearch = true
opt.incsearch = true
opt.isfname:append "@-@"
opt.splitbelow = true
opt.splitright = true
opt.number = true
opt.relativenumber = true
opt.showmode = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.cmdheight = 0
-- opt.colorcolumn = "120"
opt.laststatus = 3
opt.smartcase = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.hidden = true
opt.updatetime = 50
opt.timeoutlen = 1000
opt.ttimeoutlen = 10
opt.timeout = true
