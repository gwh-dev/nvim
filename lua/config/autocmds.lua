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
    once = true,
    callback = function()
        vim.o.statusline = "%!v:lua.require('statusline').status()"
    end,
})

autocmd("BufWritePre", {
    group = misc_aucmds,
    pattern = "*",
    callback = function()
        require("utils").mkdir()
    end,
})

