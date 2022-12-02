local cmd = vim.cmd

require "impatient"
require "opt"
require "map"

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
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
	"python_provider",
	"ruby_provider",
	"perl_provider",
	"node_provider",
}

for i = 1, 10 do
	vim.g["loaded_" .. disabled_built_ins[i]] = 1
end

-- Autocommands
local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup

local misc_aucmds = augroup("misc_aucmds", { clear = true })
autocmd("BufWinEnter", { group = misc_aucmds, command = "checktime" })
autocmd("TextYankPost", {
	group = misc_aucmds,
	callback = function()
		vim.highlight.on_yank {
			-- higroup = "IncSearch",
			timeout = 40,
		}
	end,
})

autocmd("VimEnter", {
	group = misc_aucmds,
	once = true,
	callback = function()
		-- local statusline = require("statusline")
		local O = vim.o
		O.statusline = "%!v:lua.require('statusline').status()"
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
end, {})
