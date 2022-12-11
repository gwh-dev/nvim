local fn = vim.fn
local fmt = string.format

local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_color = "%#MiniStatuslineModeOther#"
    if current_mode == "n" then
        mode_color = "%#MiniStatuslineModeNormal#"
    elseif current_mode == "i" or current_mode == "ic" then
        mode_color = "%#MiniStatuslineModeInsert#"
    elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
        mode_color = "%#MiniStatuslineModeVisual#"
    elseif current_mode == "R" then
        mode_color = "%#MiniStatuslineModeReplace#"
    elseif current_mode == "c" then
        mode_color = "%#MiniStatuslineModeCommand#"
    end
    return mode_color
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
    local info = "%l:%c %p%%"
    local format = i == 1 and "%s %d%s  " or "%s %.1f%s  "
    return fmt(format, info, size, suffixes[i])
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
        errors = "%#DiagnosticError# E:" .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = "%#DiagnosticWarn# W:" .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = "%#DiagnosticHint# H:" .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = "%#DiagnosticInfo# I:" .. count["info"]
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
            return string.upper(client.name)
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

local function status()
    local parts = {
        update_mode_colors(),
        mode(),
        "%#StatusLine#", -- Changing the colorscheme for lineinfo to 'Statusline' The normal color
        clientName(),
        get_paste(),
        get_readonly_space(),
        "%=", -- To make a large space everything down is on the right side
        diagnostic_status(), -- If I didn't put the 'Statusline' highlight, It will change the lineinfo with diagnostic_status colors
        "%#StatusLine#", -- Changing the colorscheme for lineinfo to 'Statusline' The normal color
        filesize(),
    }
    return table.concat(parts, " ")
end

return { status = status }
