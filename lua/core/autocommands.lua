vim.cmd [[autocmd FileType markdown setlocal spell]]
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

autocmd({ "BufEnter", "BufWinEnter", "CursorMoved", "WinLeave" }, {
    group = group,
    pattern = "*",
    callback = function()
        vim.o.statusline = "%!v:lua.require('core.statusline').statusline()"
    end,
    once = true,
    desc = "turn on statusline after this events",
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

-- autocmd("User", {
--     group = group,
--     pattern = "LazySync",
--     callback = function()
--         local uv = vim.loop
--         local NUM_BACKUPS = 5
--         local LOCKFILES_DIR = string.format("%s/lockfiles/", vim.fn.stdpath "config")

--         -- create if not existing
--         if not uv.fs_stat(LOCKFILES_DIR) then
--             uv.fs_mkdir(LOCKFILES_DIR, 448)
--         end

--         local lockfile = require("lazy.core.config").options.lockfile
--         if uv.fs_stat(lockfile) then
--             -- create "%Y%m%d_%H:%M:%s_lazy-lock.json" in lockfile folder
--             local filename = string.format("%s_lazy-lock.json", os.date "%Y%m%d_%H:%M:%S")
--             local backup_lock = string.format("%s/%s", LOCKFILES_DIR, filename)
--             local success = uv.fs_copyfile(lockfile, backup_lock)
--             if success then
--                 -- clean up backups in excess of `num_backups`
--                 local iter_dir = uv.fs_scandir(LOCKFILES_DIR)
--                 if iter_dir then
--                     local suffix = "lazy-lock.json"
--                     local backups = {}
--                     while true do
--                         local name = uv.fs_scandir_next(iter_dir)
--                         -- make sure we are deleting lockfiles
--                         if name and name:sub(-#suffix, -1) == suffix then
--                             table.insert(backups, string.format("%s/%s", LOCKFILES_DIR, name))
--                         end
--                         if name == nil then
--                             break
--                         end
--                     end
--                     if not vim.tbl_isempty(backups) and #backups > NUM_BACKUPS then
--                         -- remove the lockfiles
--                         for _ = 1, #backups - NUM_BACKUPS do
--                             uv.fs_unlink(table.remove(backups, 1))
--                         end
--                     end
--                 end
--             end
--             vim.notify(string.format("Backed up %s", filename), vim.log.levels.INFO, { title = "lazy.nvim" })
--         end
--     end,
-- })
