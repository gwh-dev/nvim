local api = vim.api
local fn = vim.fn
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local group = augroup("GwH", { clear = true })
autocmd("BufWinEnter", { group = group, command = "checktime" })
autocmd("TextYankPost", {
    group = augroup("HighlightYank", {}),
    callback = function()
        vim.highlight.on_yank {
            higroup = "IncSearch",
            timeout = 40,
        }
    end,
})

autocmd({ "BufWritePre" }, {
    group = group,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

autocmd({ "BufEnter", "BufWinEnter", "CursorMoved", "WinLeave" }, {
    group = augroup("status", {}),
    pattern = "*",
    callback = function()
        vim.o.statusline = "%!v:lua.require('config.statusline').statusline()"
    end,
    once = true,
    desc = "turn on statusline after this events",
})

autocmd("BufWritePre", {
    group = group,
    pattern = "*",
    callback = function()
        require("core.utils").mkdir()
    end,
    once = true,
    desc = "Create a folder if does not exist",
})

-- LSP AUTOCMDS
autocmd("BufReadPost", {
    group = group,
    pattern = "*",
    callback = function()
        local path = fn.stdpath "data" .. "/site/pack/packer/opt/nvim-lspconfig"
        if fn.empty(fn.glob(path)) > 0 then
            return
        end
        require "config.lsp"
    end,
    once = true,
    desc = "require config.lsp file after event BufReadPost",
})

autocmd("ModeChanged", {
    group = group,
    pattern = { "n:i", "v:s" },
    callback = function()
        vim.diagnostic.disable(0)
    end,
    desc = "Disable diagnostics while typing",
})

autocmd("ModeChanged", {
    group = group,
    pattern = "i:n",
    callback = function()
        vim.diagnostic.enable(0)
    end,
    desc = "Enable diagnostics when leaving insert mode",
})
