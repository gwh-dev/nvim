local opt = vim.opt
local g = vim.g

g.mapleader = [[ ]]
g.maplocalleader = [[,]]

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
    "netrwSettings",
    "netrwFileHandlers",
    "fzf",
    "getscript",
    "getscriptPlugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "tutor",
    "syntax",
    "rplugin",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for i = 1, #builtin do
    g["loaded_" .. builtin[i]] = 1
end

local default_providers = {
    "node",
    "perl",
    "python3",
    "ruby",
}

for _, provider in ipairs(default_providers) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end
