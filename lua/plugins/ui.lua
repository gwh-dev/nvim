local M = {
    {
        "monkoose/matchparen.nvim",
        event = "VeryLazy",
        config = true,
    },

    {
        "mvllow/modes.nvim",
        event = "VeryLazy",
        config = {
            colors = {
                copy = "#e5c07b",
                delete = "#e06c75",
                insert = "#56b6c2",
                visual = "#c678dd",
            },
            ignore_filetypes = { "neo-tree", "TelescopePrompt" },
        },
    },

    {
        "akinsho/nvim-bufferline.lua",
        event = "BufAdd",
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                diagnostics_indicator = function(_, _, diag)
                    local icons = {
                        Error = " ",
                        Warn = " ",
                        Hint = " ",
                        Info = " ",
                    }
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
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
