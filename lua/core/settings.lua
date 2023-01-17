local opt = vim.opt
local g = vim.g

g.mapleader = [[ ]]
g.maplocalleader = [[,]]

g.clipboard = { -- I don't Know if this help or not
    name = "xclip",
    copy = {
        ["+"] = "xclip -quiet -i -selection clipboard",
        ["*"] = "xclip -quiet -i --selection primary",
    },
    paste = {
        ["+"] = "xclip -o -selection clipboard",
        ["*"] = "xclip  -o -selection primary",
    },
    cache_enabled = 1,
}

g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

opt.termguicolors = true

opt.foldmethod = "manual"
opt.foldenable = false
vim.o.winbar = " "
opt.splitkeep = "screen"
vim.o.shortmess = "filnxtToOFWIcC"
opt.swapfile = false
opt.backup = false
opt.undodir = "/home/gwh/.vim/undodir"
opt.fillchars = { eob = " " } -- make EndOfBuffer invisible
opt.wrap = false
opt.undofile = true
opt.wildmode = "longest:full,full"
opt.wildignorecase = true
opt.ignorecase = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.scrolloff = 8
-- opt.lazyredraw = true
opt.showmatch = true
opt.ignorecase = true
opt.hlsearch = true
opt.incsearch = true
opt.isfname:append "@-@"
opt.splitbelow = true
opt.splitright = true
opt.number = true
opt.relativenumber = false
opt.showmode = false
opt.cursorline = true
opt.signcolumn = "yes"
-- opt.cmdheight = 0
opt.colorcolumn = "120"
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
