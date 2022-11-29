local opt = vim.opt

-- Settings
opt.textwidth = 100
opt.scrolloff = 7
opt.wildignore = { "*.o", "*~", "*.pyc" }
opt.wildmode = "longest,full"
opt.whichwrap:append "<,>,h,l"
opt.inccommand = "nosplit"
opt.lazyredraw = true
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.tabstop = 2
opt.softtabstop = 0
opt.expandtab = true
opt.shiftwidth = 2
opt.number = false
opt.relativenumber = false
opt.smartindent = true
opt.laststatus = 3
opt.showmode = false
opt.shada = [['20,<50,s10,h,/100]]
opt.hidden = true
opt.shortmess:append "c"
opt.joinspaces = false
opt.guicursor = "a:blinkwait700-blinkon400-blinkoff250"
opt.updatetime = 100
opt.conceallevel = 2
opt.concealcursor = "nc"
opt.previewheight = 5
opt.undofile = true
opt.synmaxcol = 500
opt.display = "msgsep"
opt.cursorline = true
opt.modeline = false
opt.mouse = "nivh"
opt.signcolumn = "yes:1"
opt.cmdheight = 0
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 400
opt.fillchars = [[vert:│,horiz:─,eob: ]]

opt.termguicolors = true
