local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
}

local function lsp_list()
    local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }

    if next(buf_clients) == nil then
        return "No LSP attached"
    end

    local buf_client_names = {}

    -- Получает все клиенты LSP, которые не null-ls
    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    return table.concat(buf_client_names, ", ")
end

local function formatters_list()
    local formatters = require "config.lsp.formatters"
    local buf_ft = vim.bo.filetype
    local supported_formatters = formatters.list_registered(buf_ft)
    return table.concat(supported_formatters, ", ")
end

function M.config()
    local colors = require("onedarkpro.helpers").get_colors()
    local config = require("onedarkpro.config").config

    local inactive_bg = config.options.highlight_inactive_windows and colors.color_column or colors.bg
    local onedarkpro = {
        normal = {
            a = { bg = colors.green, fg = colors.bg },
            b = { bg = colors.fg_gutter, fg = colors.green },
            c = { bg = colors.bg_statusline, fg = colors.fg },
        },

        insert = {
            a = { bg = colors.blue, fg = colors.bg },
            b = { bg = colors.fg_gutter, fg = colors.blue },
        },

        command = {
            a = { bg = colors.purple, fg = colors.bg },
            b = { bg = colors.fg_gutter, fg = colors.purple },
        },

        visual = {
            a = { bg = colors.yellow, fg = colors.bg },
            b = { bg = colors.fg_gutter, fg = colors.yellow },
        },

        replace = {
            a = { bg = colors.red, fg = colors.bg },
            b = { bg = colors.fg_gutter, fg = colors.red },
        },

        inactive = {
            a = { bg = inactive_bg, fg = colors.blue },
            b = { bg = inactive_bg, fg = colors.fg_gutter_inactive, gui = "bold" },
            c = { bg = inactive_bg, fg = colors.fg_gutter_inactive },
        },
    }
    require("lualine").setup {
        options = {
            theme = onedarkpro,
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
            icons_enabled = true,
            globalstatus = true,
            disabled_filetypes = { statusline = { "dashboard", "lazy" } },
        },
        sections = {
            lualine_a = { { "mode", separator = { left = "" } } },
            lualine_b = { "branch" },
            lualine_c = {
                { "diagnostics", sources = { "nvim_diagnostic" } },
                { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                { "filename", path = 1, symbols = { modified = "", readonly = "", unnamed = "" } },
            },
            lualine_x = {
                -- {
                --     lsp_list,
                --     icon = " LSP:",
                --     icons_enabled = true,
                -- },
                {
                    formatters_list,
                    icon = " Formatter:",
                    icons_enabled = true,
                },
                {
                    function()
                        return require("lazy.status").updates()
                    end,
                    cond = require("lazy.status").has_updates,
                    color = { fg = colors.orange },
                },
                {
                    function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        return " " .. ms .. "ms"
                    end,
                    color = { fg = colors.orange },
                },
            },
            lualine_y = { "location" },
            lualine_z = { { "filesize", separator = { right = "" } } },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        extensions = { "neo-tree" },
    }
end

return M
