local api = vim.api
local autocmd = api.nvim_create_autocmd
local misc_aucmds = api.nvim_create_augroup("misc_aucmds", { clear = true })

autocmd("BufWinEnter", { group = misc_aucmds, command = "checktime" })
autocmd("TextYankPost", {
    group = misc_aucmds,
    callback = function()
        vim.highlight.on_yank {
            higroup = "IncSearch",
            timeout = 40,
        }
    end,
})

autocmd({ "BufEnter", "BufWinEnter", "CursorMoved", "WinLeave" }, {
    group = misc_aucmds,
    pattern = "*",
    callback = function()
        vim.opt.laststatus = 3
        vim.o.statusline = "%!v:lua.require('config.statusline').statusline()"
    end,
    once = true,
})

autocmd("BufWritePre", {
    group = misc_aucmds,
    pattern = "*",
    callback = function()
        require("core.utils").mkdir()
    end,
    once = true,
})

autocmd("BufReadPost", {
    group = misc_aucmds,
    pattern = "*",
    callback = function()
        require "config.lsp"
    end,
    once = true,
})
