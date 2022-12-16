local opt = vim.opt
opt.termguicolors = true

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

opt.wildoptions = "pum"
opt.wildignorecase = true -- Ignore case when completing file names and directories
opt.wildcharm = 26 -- equals set wildcharm=<C-Z>, used in the mapping section
opt.pumheight = 20 -- Limit the amount of autocomplete items shown

opt.completeopt = { "menu", "menuone", "noselect" }
opt.backspace = { "eol", "start", "indent" }
opt.encoding = "utf-8"
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.textwidth = 100
opt.scrolloff = 7
opt.clipboard = "unnamedplus"
opt.whichwrap:append "<,>,h,l"
opt.inccommand = "nosplit"
opt.lazyredraw = true
opt.showmatch = true
opt.ignorecase = true
opt.number = true
opt.relativenumber = true
opt.smartcase = true
opt.tabstop = 2
opt.softtabstop = 0
opt.expandtab = true
-- opt.syntax = "disable"
-- opt.showmode = false
opt.shiftwidth = 2
opt.smartindent = true
opt.shada = [['20,<50,s10,h,/100]]
opt.hidden = true
opt.shortmess:append "c"
opt.guicursor = "a:blinkwait700-blinkon400-blinkoff250"
opt.joinspaces = false
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
-- opt.cmdheight = 0
opt.splitbelow = true
opt.splitright = true
opt.fillchars = [[vert:│,horiz:─,eob: ]]

local g = vim.g

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
