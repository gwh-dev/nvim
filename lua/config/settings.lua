local g = vim.g

vim.o.winbar = " "

local builtin = {
    "gzip",
    "2html_plugin",
    "man",
    "matchit",
    "matchparen",
    "shada_plugin",
    "tarPlugin",
    "tar",
    "zipPlugin",
    "zip",
    "netrw",
    "netrwPlugin",
    "remote_plugins",
    "fzf",
    "perl_provider",
    "node_provider",
    "python3_provider",
    "ruby_provider",
}

for i = 1, #builtin do
    g["loaded_" .. builtin[i]] = 0
end

g.clipboard = {
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

local opt = vim.opt
opt.wildoptions = "pum"
opt.wildignorecase = true -- Ignore case when completing file names and directories
opt.wildcharm = 26 -- equals set wildcharm=<C-Z>, used in the mapping section
opt.pumheight = 20 -- Limit the amount of autocomplete items shown
opt.textwidth = 100
opt.scrolloff = 7
opt.clipboard = "unnamedplus"
opt.whichwrap:append "<,>,h,l"
opt.inccommand = "nosplit"
opt.lazyredraw = true
opt.showmatch = true
opt.ignorecase = true
opt.nu = true
opt.relativenumber = true
opt.smartcase = true
opt.tabstop = 2
opt.softtabstop = 0
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.laststatus = 3
opt.showmode = false
opt.shada = [['20,<50,s10,h,/100]]
opt.hidden = true
opt.shortmess:append "c"
opt.joinspaces = false
opt.guicursor = "a:blinkwait700-blinkon400-blinkoff250"
opt.updatetime = 50
opt.timeoutlen = 1000
opt.ttimeoutlen = 10
opt.timeout = true
opt.conceallevel = 2
opt.concealcursor = "nc"
opt.previewheight = 5
opt.undofile = true
opt.synmaxcol = 500
opt.display = "msgsep"
opt.cursorline = true
opt.modeline = false
opt.mouse = "nivh"
opt.signcolumn = "yes"
opt.cmdheight = 0
opt.splitbelow = true
opt.splitright = true
opt.fillchars = [[vert:│,horiz:─,eob: ]]
opt.termguicolors = true
