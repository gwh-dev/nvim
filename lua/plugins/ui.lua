vim.cmd "lua vim.g.neo_tree_remove_legacy_commands = 1"
local M = {
    {
        "monkoose/matchparen.nvim",
        event = "VeryLazy",
        config = true,
    },

    {
        "j-hui/fidget.nvim",
        event = "BufReadPre",
        config = {
            text = {
                spinner = "moon",
            },
            align = {
                bottom = true,
            },
            window = {
                relative = "editor",
                blend = 0,
            },
            sources = {
                ["null-ls"] = { ignore = true },
            },
        },
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        keys = {
            { "<leader>e", [[<cmd>Neotree toggle<cr>]], desc = "File Browser" },
        },
        config = {
            filesystem = {
                follow_current_file = true,
                hijack_netrw_behavior = "open_current",
            },
        },
    },

    {
        "b0o/incline.nvim",
        event = "BufReadPre",
        config = function()
            local colors = require("onedarkpro.helpers").get_colors()

            require("incline").setup {
                highlight = {
                    groups = {
                        InclineNormal = {
                            guifg = colors.orange,
                            guibg = colors.bg,
                            -- gui = "bold",
                        },
                        InclineNormalNC = {
                            guifg = colors.fg,
                            guibg = colors.bg,
                        },
                    },
                },
                window = {
                    margin = {
                        vertical = 0,
                        horizontal = 1,
                    },
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    local icon, color = require("nvim-web-devicons").get_icon_color(filename)
                    return {
                        { icon, guifg = color },
                        { " " },
                        { filename },
                    }
                end,
            }
        end,
    },
}

return M
