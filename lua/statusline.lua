local path_sep = require("plenary.path").path.sep

local fn = vim.fn
local api = vim.api
local fmt = string.format

local function lineinfo()
    return "%l:%c - %p%%"
end

local function filesize()
    local file = fn.expand("%:p")

    if file == nil or #file == 0 then
        return ""
    end

    local size = fn.getfsize(file)

    if size <= 0 then
        return ""
    end

    local suffixes = { "b", "k", "m", "g" }
    local i = 1
    while size > 1024 and i < #suffixes do
        size = size / 1024
        i = i + 1
    end

    local format = i == 1 and "%d%s" or "%.1f%s"
    return fmt(format, size, suffixes[i])
end

local function fname()
    local path_head = fn.expand("%:h")

    if path_head ~= "" then
        path_head = "%#StatusLineNC# " .. path_head .. path_sep .. "%*%#CursorLineNr#%t %*"
    end

    local fileModified = '%{&modified?"":""}'
    local fileHelp = "%h"

    return fmt("%s%s %s", path_head, fileModified, fileHelp)
end

local function lsp_progress()
    local buf_ft = api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    local lsp = vim.lsp.util.get_progress_messages()[1]

    if lsp then
        local name = lsp.name or ""
        local msg = lsp.message or ""
        local percentage = lsp.percentage or 0
        local title = lsp.title or ""
        return fmt("%%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
    end

    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
        end
    end

    return "" -- return "Nothing" if there is no lsp client
end

local function diagnostic_status()
    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint",
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""

    if count["errors"] ~= 0 then
        errors = " %#DiagnosticError#E:" .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = " %#DiagnosticWarn#W:" .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = " %#DiagnosticHint#H:" .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = " %#DiagnosticInfo#I:" .. count["info"]
    end

    return fmt("%s%s%s%s", errors, warnings, hints, info)
end

local function status()
    local parts = {
        fname(),
        "%#StatusLineNC#",
        "|  ",
        "%#StatusLine#",
        lsp_progress(),
        "%=", -- To make a large space everything down is on the right side
        diagnostic_status(), -- If I didn't put the 'Statusline' highlight, It will change the lineinfo with diagnostic_status colors
        "%#StatusLineNC#",
        " | ",
        "%#StatusLine#", -- Changing the colorscheme for lineinfo to 'Statusline' The normal color
        lineinfo(), -- {col number} { the place using % }
        "%#StatusLineNC#",
        " | ",
        "%#StatusLine#", -- Changing the colorscheme for lineinfo to 'Statusline' The normal color
        filesize(),
    }
    return table.concat(parts, "")
end

return { status = status }
