local opt = vim.opt

opt.list = true
opt.listchars:append {
    tab = "❘-",
    trail = "·",
    lead = "·",
    extends = "»",
    precedes = "«",
    nbsp = "×",
    -- eol = "↴",
}

opt.swapfile = false
opt.backup = false
opt.undodir = "/home/gwh/.vim/undodir"
opt.undofile = true

opt.wildignorecase = true -- Ignore case when completing file names and directories

opt.completeopt = { "menu", "menuone", "noselect" }

opt.scrolloff = 8
opt.lazyredraw = true
opt.showmatch = true
opt.ignorecase = true
opt.hlsearch = false
opt.incsearch = true
opt.isfname:append "@-@"

opt.number = true
opt.relativenumber = false
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cmdheight = 0
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
