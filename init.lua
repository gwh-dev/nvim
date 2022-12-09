local cmd = vim.cmd
local g = vim.g

pcall(require, "impatient")

-- Leader/local leader
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Some plugins
g.did_load_filetypes = 1

-- Disable providers that we don't want
local providers = {
  "perl",
  "node",
  "python3",
  "ruby",
}

for i = 1, 4 do
  g["loaded_" .. providers[i] .. "_provider"] = 0
end

-- Disable some built-in plugins we don't want
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
}

for i = 1, 12 do
  g["loaded_" .. builtin[i]] = 1
end

-- Autocommands
local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local GwH = augroup("misc_aucmds", { clear = true })

local yank_group = augroup("HighlightYank", {})

autocmd("BufWinEnter", { group = GwH, command = "checktime" })
autocmd("TextYankPost", {
  group = yank_group,
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 40,
    }
  end,
})

autocmd("VimEnter", {
  group = GwH,
  once = true,
  callback = function()
    vim.o.statusline = "%!v:lua.require('statusline').status()"
  end,
})

autocmd("BufWritePre", {
  group = GwH,
  command = "%s/\\s\\+$//e",
})

local mkdir = augroup("MkdirRun", {})

autocmd("BufWritePre", {
  group = mkdir,
  pattern = "*",
  callback = function()
    require("utils").mkdir()
  end,
})

-- Commands
local create_cmd = api.nvim_create_user_command
create_cmd("PackerInstall", function()
  cmd [[packadd packer.nvim]]
  require("plugins").install()
end, {})
create_cmd("PackerUpdate", function()
  cmd [[packadd packer.nvim]]
  require("plugins").update()
end, {})
create_cmd("PackerSync", function()
  cmd [[packadd packer.nvim]]
  require("plugins").sync()
end, {})
create_cmd("PackerClean", function()
  cmd [[packadd packer.nvim]]
  require("plugins").clean()
end, {})
create_cmd("PackerCompile", function()
  cmd [[packadd packer.nvim]]
  require("plugins").compile()
end, {})
create_cmd("PackerStatus", function()
  cmd [[packadd packer.nvim]]
  require("plugins").status()
end, {})

local map = vim.keymap.set

-- Clear Highlighting until the next search
local expr = { expr = true, noremap = false, silent = false }
map("n", "j", "(v:count ? 'j' : 'gj')", expr)
map("n", "k", "(v:count ? 'k' : 'gk')", expr)
map("", "<Down>", "(v:count ? 'j' : 'gj')", expr)
map("", "<Up>", "(v:count ? 'k' : 'gk')", expr)
local remap = { remap = true, silent = true }
-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h", remap)
map("n", "<C-j>", "<C-w>j", remap)
map("n", "<C-k>", "<C-w>k", remap)
map("n", "<C-l>", "<C-w>l", remap)

map("n", "<C-d>", "<C-d>zz", remap)
map("n", "<C-u>", "<C-u>zz", remap)

map("n", "n", "nzzzv", remap)
map("n", "N", "Nzzzv", remap)
-- Resize with arrows
map("n", "<A-j>", "<cmd>resize -2<CR>")
map("n", "<A-k>", "<cmd>resize +2<CR>")
map("n", "<A-h>", "<cmd>vertical resize -2<CR>")
map("n", "<A-l>", "<cmd>vertical resize +2<CR>")

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")

-- map({ "n", "v", "x" }, "y+", [[<cmd>set opfunc=util#clipboard_yank<cr>g@]], { nowait = true })
local nowait = { nowait = true, silent = true }
-- Stop Highlighting
map("n", "<leader>h", "<cmd>noh<CR>", nowait)

-- Telescope
map("n", "<leader>fi", [[<cmd>Telescope find_files theme=get_dropdown<cr>]], nowait)

map("n", "<leader>l", [[<cmd>Telescope live_grep theme=get_dropdown<cr>]], nowait)

map("n", "<leader>d", [[<cmd>Telescope diagnostics theme=get_dropdown<cr>]], nowait)

map("n", "<leader>p", [[<cmd>Telescope neoclip a extra=star,plus,b theme=get_dropdown<cr>]], nowait)

local opt = vim.opt

-- Binary
opt.wildignore = {
  "*.aux,*.out,*.toc",
  "*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class",
  -- media
  "*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
  "*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
  "*.eot,*.otf,*.ttf,*.woff",
  "*.doc,*.pdf",
  -- archives
  "*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
  -- temp/system
  "*.*~,*~ ",
  "*.swp,.lock,.DS_Store,._*,tags.lock",
  -- version control
  ".git,.svn",
}

opt.wildoptions = "pum"
opt.wildignorecase = true -- Ignore case when completing file names and directories
opt.wildcharm = 26 -- equals set wildcharm=<C-Z>, used in the mapping section
opt.pumheight = 20 -- Limit the amount of autocomplete items shown
opt.textwidth = 100
opt.scrolloff = 7
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
