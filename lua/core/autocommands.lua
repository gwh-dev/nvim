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
    desc = "turn on statusline after this events",
    callback = function()
        vim.o.statusline = "%!v:lua.require('config.statusline').statusline()"
    end,
    once = true,
})

autocmd("BufWritePre", {
    group = misc_aucmds,
    pattern = "*",
    desc = "Create a folder if does not exist",
    callback = function()
        require("core.utils").mkdir()
    end,
    once = true,
})

-- LSP AUTOCMDS
autocmd("BufReadPost", {
    group = misc_aucmds,
    pattern = "*",
    desc = "require config.lsp file after event BufReadPost",
    callback = function()
        require "config.lsp"
    end,
    once = true,
})

autocmd("ModeChanged", {
    group = misc_aucmds,
    pattern = { "n:i", "v:s" },
    desc = "Disable diagnostics while typing",
    callback = function()
        vim.diagnostic.disable(0)
    end,
})

autocmd("ModeChanged", {
    group = misc_aucmds,
    pattern = "i:n",
    desc = "Enable diagnostics when leaving insert mode",
    callback = function()
        vim.diagnostic.enable(0)
    end,
})
