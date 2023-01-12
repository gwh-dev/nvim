vim.cmd [[autocmd FileType markdown setlocal spell]]
local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local group = augroup("GwH", { clear = true })

autocmd({ "FocusGained", "TermClose", "TermLeave" }, { group = group, command = "checktime" })

autocmd("TextYankPost", {
    group = augroup("HighlightYank", {}),
    callback = function()
        vim.highlight.on_yank {
            higroup = "IncSearch",
            timeout = 40,
        }
    end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
    group = group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
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

autocmd({ "BufEnter" }, {
    group = group,
    pattern = "*.norg",
    callback = function()
        vim.opt.relativenumber = false
        vim.opt.cursorline = false
        vim.opt.laststatus = 0
        vim.cmd [[Neorg inject-metadata]]
    end,
})

autocmd({ "BufLeave" }, {
    group = group,
    pattern = "*.norg",
    callback = function()
        vim.opt.relativenumber = true
        vim.opt.cursorline = true
        vim.opt.laststatus = 3
    end,
})

autocmd({ "BufWritePre" }, {
    group = group,
    pattern = "*",
    command = "%s/\\s\\+$//e",
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

autocmd("User", {
    group = group,
    pattern = "LazySync",
    command = "OnedarkproCache",
})
