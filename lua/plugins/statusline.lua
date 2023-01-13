local function lsp_client(msg)
    msg = msg or ""

    local buf_clients = vim.lsp.buf_get_clients()
    local method = {
        "FORMATTING",
        "DIAGNOSTICS",
        "CODE_ACTION",
    }

    if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
            return ""
        end
        return msg
    end

    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    for value in pairs(method) do
        local utils = require "core.utils"
        local null_ls = require "null-ls"
        local supported = utils.list_registered(buf_ft, null_ls.methods[method[value]])
        vim.list_extend(buf_client_names, supported)
    end

    -- add client
    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
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
                    component_separators = {},
                    icons_enabled = true,
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "alpha", "lazy" } },
                },
                sections = {
                    lualine_a = { { "mode" } }, -- separator = { left = "" } } },
                    lualine_b = { "branch" },
                    lualine_x = {
                        { "diagnostics", sources = { "nvim_diagnostic" } },
                        { lsp_client, icon = " ", color = { fg = colors.violet, gui = "bold" } },
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
                    lualine_z = { { "filesize" } }, --separator = { right = "" } } },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                winbar = {
                    lualine_b = {
                        {
                            "filetype",
                            separator = { right = "" },
                            icon_only = true,
                            -- colored = false,
                            padding = { left = 1, right = 0 },
                        },
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                            separator = { right = "" },
                            symbols = { modified = "", readonly = "", unnamed = "" },
                        },
                        {
                            function()
                                local ret = require("nvim-navic").get_location()
                                return ret:len() > 2000 and "navic error" or ret
                            end,
                            cond = function()
                                if package.loaded["nvim-navic"] then
                                    return require("nvim-navic").is_available()
                                end
                            end,
                            color = { bg = colors.bg_statusline },
                        },
                    },
                },
                extensions = { "neo-tree" },
            }
        end,
    },
}
