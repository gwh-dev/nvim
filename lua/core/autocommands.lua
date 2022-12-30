local api = vim.api
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

autocmd({ "FileType" }, {
    group = group,
    pattern = { "json", "jsonc" },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
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
        vim.o.statusline = "%!v:lua.require('core.statusline').statusline()"
    end,
    once = true,
})

autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
    callback = function(event)
        local file = vim.loop.fs_realpath(event.match) or event.match

        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        local backup = vim.fn.fnamemodify(file, ":p:~:h")
        backup = backup:gsub("[/\\]", "%%")
        vim.go.backupext = backup
    end,
})

-- LSP AUTOCMDS
autocmd("ModeChanged", {
    group = group,
    pattern = { "n:i", "v:s" },
    callback = function()
        vim.diagnostic.disable(0)
    end,
})

autocmd("ModeChanged", {
    group = group,
    pattern = "i:n",
    callback = function()
        vim.diagnostic.enable(0)
    end,
})
