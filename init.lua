local g = vim.g
local cmd = vim.cmd
local opt = vim.opt
opt.termguicolors = true

require "impatient"

vim.g.do_filetype_lua = 1
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Skip some remote provider loading
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

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
opt.number = true
opt.relativenumber = true
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

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
	"gzip",
	"man",
	"matchit",
	"matchparen",
	"shada_plugin",
	"tarPlugin",
	"tar",
	"zipPlugin",
	"zip",
	"netrwPlugin",
}

for i = 1, 10 do
	g["loaded_" .. disabled_built_ins[i]] = 1
end

-- Autocommands
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local misc_aucmds = augroup("misc_aucmds", { clear = true })
autocmd("BufWinEnter", { group = misc_aucmds, command = "checktime" })
autocmd("TextYankPost", {
	group = misc_aucmds,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Commands
local create_cmd = vim.api.nvim_create_user_command
create_cmd("PackerInstall", function()
	cmd [[packadd packer.nvim]]
	require("plugins").install()
end, {})
create_cmd("PackerUpdate", function()
	cmd [[packadd packer.nvim]]
	require("plugins").update()
end, {})
create_cmd("PackerStatus", function()
	cmd [[packadd packer.nvim]]
	require("plugins").status()
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
	require("catppuccin").compile()
end, {})
