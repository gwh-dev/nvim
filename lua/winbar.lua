local lspsaga = require "lspsaga.symbolwinbar"
local path_sep = require("plenary.path").path.sep

local function fname()
    local path_head = vim.fn.expand "%:h"
    local sym = lspsaga.get_symbol_node()
    if sym == nil then
        return ""
    end
    if path_head ~= "" then
        local t = "%*%#@comment#%t%*"
        path_head = "%#@comment#" .. path_head
        path_sep = "%#@comment#" .. path_sep
        path_head = string.format(" %s%s%s%s", path_head, path_sep, t, sym)
    end
    return path_head
end

local function bar()
    local exclude = {
        ["telescope"] = true,
        ["packer"] = true,
        ["help"] = true,
    } -- Ignore float windows and exclude filetype
    if exclude[vim.bo.filetype] then
        return ""
    end
    return fname()
end

return { bar = bar }
