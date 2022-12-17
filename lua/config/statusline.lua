local fn = vim.fn
local fmt = string.format

local function fname()
    local path_head = fn.expand "%:h"
    if path_head ~= "" then
        path_head = "%#StatusLineNC# " .. path_head .. "%#StatusLine#" .. "/%t"
    end
    local fileModified = ' %{&modified?"":""}'
    return path_head .. fileModified
end

local function encoding()
    local opt = vim.opt.fileencoding:get()
    return fmt("[%s] ", opt):upper()
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
    local format = i == 1 and " %d%s" or " %.1f%s"
    return fmt(format, size, suffixes[i])
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
        errors = "%#DiagnosticFloatingError# E:" .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = "%#DiagnosticFloatingWarn# W:" .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = "%#DiagnosticFloatingHint# H:" .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = "%#DiagnosticFloatingInfo# I:" .. count["info"]
    end

    return errors .. warnings .. hints .. info
end

local function clientName()
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return ""
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return "|  " .. string.upper(client.name)
        end
    end
    return ""
end

local function get_paste()
    return vim.o.paste and "PASTE " or ""
end

local function get_readonly_space()
    return ((vim.o.paste and vim.bo.readonly) and " " or "") and "%r" .. (vim.bo.readonly and " " or "")
end

local function statusline()
    local parts = {
        fname(),
        clientName(),
        get_paste(),
        get_readonly_space(),
        diagnostic_status(),
        -- diagnostic_status(), -- if i didn't put the 'statusline' highlight, it will change the lineinfo with diagnostic_status colors
        "%#StatusLine#", -- Changing the colorscheme for lineinfo to 'Statusline' The normal color
        "%=", -- To make a large space everything down is on the right side
        -- "%#StatusLine#", -- Changing the colorscheme for lineinfo to 'Statusline' The normal color
        "%1l%L%*",
        " %1c",
        filesize(),
        encoding(),
    }
    return table.concat(parts, " ")
end

return { statusline = statusline }
