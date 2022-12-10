local path_sep = require("plenary.path").path.sep
-- local lspsaga = require "lspsaga.symbolwinbar"

local fn = vim.fn
local fmt = string.format

local function lineinfo()
    return "%l:%c - %p%% "
end
local function filesize()
    local file = fn.expand "%:p"

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

    local format = i == 1 and "%d%s  " or "%.1f%s  "
    return fmt(format, size, suffixes[i])
end

local function fname()
    local path_head = fn.expand "%:h"

    if path_head ~= "" then
        path_head = "%#StatusLineNC# " .. path_head .. path_sep .. "%*%#StatusLine#%t%*"
    end

    local fileModified = ' %{&modified?"":""}'
    local fileHelp = " %h"

    return path_head .. fileModified .. fileHelp
end

-- local function lsp()
--     local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
--     local clients = vim.lsp.get_active_clients()
--     local progress = vim.lsp.util.get_progress_messages()[1]

--     if progress then
--         local name = progress.name or ""
--         local msg = progress.message or ""
--         local percentage = progress.percentage or 0
--         local title = progress.title or ""
--         return fmt("%%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
--     end

--     for _, client in ipairs(clients) do
--         local filetypes = client.config.filetypes
--         if filetypes and fn.index(filetypes, buf_ft) ~= -1 then
--             return client.name
--         end
--     end

--     return ""
-- end

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

    return errors .. warnings .. hints .. info
end

-- local function symbol()
--     local sym = lspsaga.get_symbol_node()
--     if sym == nil then
--         return ""
--     end
--     return sym
-- end

local function status()
    local exclude = {
        ["telescope"] = true,
        ["packer"] = true,
        ["help"] = true,
    } -- Ignore float windows and exclude filetype
    if exclude[vim.bo.filetype] then
        return ""
    end

    local parts = {
        fname(), -- show to right path from the last place I have been
        "%#statuslinenc#|", -- separator
        -- "%#StatusLine#", -- highlight group
        -- lsp(), -- lsp client name and progress
        -- "%=", -- To make a large space everything down is on the right side
        -- symbol(),
        "%=", -- To make a large space everything down is on the right side
        diagnostic_status(), -- If I didn't put the 'Statusline' highlight, It will change the lineinfo with diagnostic_status colors
        "%#StatusLineNC#|", -- separator
        "%#StatusLine#", -- Changing the colorscheme for lineinfo to 'Statusline' The normal color
        lineinfo(), -- {col number} { the place using % }
        "%#StatusLineNC#|", -- separator
        "%#StatusLine#", -- Changing the colorscheme for lineinfo to 'Statusline' The normal color
        filesize(),
    }
    return table.concat(parts, " ")
end

return { status = status }
