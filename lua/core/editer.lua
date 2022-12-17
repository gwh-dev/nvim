local opt = vim.opt
local g = vim.g

g.mapleader = [[ ]]
g.maplocalleader = [[,]]

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

opt.wildoptions = "pum"
opt.wildignorecase = true -- Ignore case when completing file names and directories
opt.wildcharm = 26 -- equals set wildcharm=<C-Z>, used in the mapping section
opt.pumheight = 20 -- Limit the amount of autocomplete items shown

opt.completeopt = { "menu", "menuone", "noselect" }

opt.scrolloff = 8
opt.clipboard = "unnamedplus"
opt.lazyredraw = true
opt.showmatch = true
opt.ignorecase = true

opt.number = true
opt.relativenumber = true
opt.termguicolors = true
-- opt.guicursor = "a:blinkon400-blinkwait700-blinkoff250"
opt.guicursor = "a:blinkwait700-blinkoff400-blinkon250"
opt.laststatus = 3

opt.smartcase = true

opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
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
