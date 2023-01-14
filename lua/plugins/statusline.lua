-- local colors = require "gruvbox.palette"

-- local gruvbox = {
--     normal = {
--         a = { bg = colors.bright_green, fg = colors.dark2 },
--         b = { bg = colors.dark2, fg = colors.bright_green },
--         c = { bg = colors.dark0_soft, fg = colors.light0_soft },
--     },

--     insert = {
--         a = { bg = colors.bright_blue, fg = colors.dark2 },
--         b = { bg = colors.dark2, fg = colors.bright_blue },
--     },

--     command = {
--         a = { bg = colors.bright_purple, fg = colors.dark2 },
--         b = { bg = colors.dark2, fg = colors.bright_purple },
--     },

--     visual = {
--         a = { bg = colors.bright_yellow, fg = colors.dark2 },
--         b = { bg = colors.dark2, fg = colors.bright_yellow },
--     },

--     replace = {
--         a = { bg = colors.bright_red, fg = colors.dark2 },
--         b = { bg = colors.dark2, fg = colors.bright_red },
--     },
-- }
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
            -- local colors = require "gruvbox.palette"

            require("lualine").setup {
                options = {
                    section_separators = { left = "", right = "" },
                    component_separators = {},
                    icons_enabled = true,
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "alpha", "lazy" } },
                },
                sections = {
                    lualine_a = { { "mode" } }, -- separator = { left = "" } } },
                    lualine_b = { "branch" },
                    lualine_c = {
                        { "diagnostics", sources = { "nvim_diagnostic" } },
                    },
                    lualine_x = {
                        { lsp_client, icon = " " },
                        {
                            function()
                                return require("lazy.status").updates()
                            end,
                            cond = require("lazy.status").has_updates,
                        },
                        {
                            function()
                                local stats = require("lazy").stats()
                                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                                return " " .. ms .. "ms"
                            end,
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
                    lualine_a = {},
                    lualine_b = {
                        {
                            "filetype",
                            separator = { right = "" },
                            icon_only = true,
                            -- colored = false,
                            padding = { left = 1, right = 0 },
                        },
                        {
                            "filename",
                            path = 1,
                            separator = { right = "" },
                            symbols = { modified = "", readonly = "", unnamed = "" },
                        },
                    },
                    lualine_c = {
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
                        },
                    },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                extensions = { "neo-tree" },
            }
        end,
    },
}
