local api = vim.api
local fn = vim.fn
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local GwHGroup = augroup("GwH", { clear = true })
local yank_group = augroup("HighlightYank", {})

autocmd("BufWinEnter", { group = GwHGroup, command = "checktime" })
autocmd("TextYankPost", {
    group = yank_group,
    callback = function()
        vim.highlight.on_yank {
            higroup = "IncSearch",
            timeout = 40,
        }
    end,
})

-- vim.cmd "autocmd ColorScheme * lua require('leap').init_highlight(true)"
-- autocmd("ColorScheme", {
--     pattern = "*",
--     group = GwHGroup,
--     callback = function()
--         require("leap").init_highlight(true)
--     end,
-- })

autocmd({ "BufWritePre" }, {
    group = GwHGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

autocmd({ "BufEnter", "BufWinEnter", "CursorMoved", "WinLeave" }, {
    group = GwHGroup,
    pattern = "*",
    callback = function()
        vim.o.statusline = "%!v:lua.require('config.statusline').statusline()"
    end,
    once = true,
    desc = "turn on statusline after this events",
})

autocmd("BufWritePre", {
    group = GwHGroup,
    pattern = "*",
    callback = function()
        require("core.utils").mkdir()
    end,
    once = true,
    desc = "Create a folder if does not exist",
})

-- LSP AUTOCMDS
autocmd("BufReadPost", {
    group = GwHGroup,
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
    group = GwHGroup,
    pattern = { "n:i", "v:s" },
    callback = function()
        vim.diagnostic.disable(0)
    end,
    desc = "Disable diagnostics while typing",
})

autocmd("ModeChanged", {
    group = GwHGroup,
    pattern = "i:n",
    callback = function()
        vim.diagnostic.enable(0)
    end,
    desc = "Enable diagnostics when leaving insert mode",
})
