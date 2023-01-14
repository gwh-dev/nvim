return {
    {
        {
            "monkoose/matchparen.nvim",
            event = "VeryLazy",
            config = true,
        },

        {
            "stevearc/dressing.nvim",
            event = "VeryLazy",
            config = {
                select = {
                    backend = { "nui", "telescope", "builtin" },
                    input = {
                        override = function(conf)
                            conf.col = -1
                            conf.row = 0
                            return conf
                        end,
                    },
                },
            },
        },

        -- {
        --     "mvllow/modes.nvim",
        --     event = "VeryLazy",
        --     config = {
        --         colors = {
        --             copy = "#e5c07b",
        --             delete = "#e06c75",
        --             insert = "#56b6c2",
        --             visual = "#c678dd",
        --         },
        --         ignore_filetypes = { "neo-tree", "TelescopePrompt" },
        --     },
        -- },

        {
            "akinsho/nvim-bufferline.lua",
            event = "BufAdd",
            config = {
                -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
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
                -- local colors = require("onedarkpro.helpers").get_colors()

                require("incline").setup {
                    -- highlight = {
                    --     groups = {
                    -- InclineNormal = {
                    --     guifg = colors.orange,
                    --     guibg = colors.bg,
                    --     -- gui = "bold",
                    -- },
                    -- InclineNormalNC = {
                    --     guifg = colors.fg,
                    --     guibg = colors.bg,
                    -- },
                    --     },
                    -- },
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
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        dependencies = {
            "echasnovski/mini.indentscope",
            config = function()
                require("mini.indentscope").setup {
                    draw = {
                        delay = 50,
                    },
                }
            end,
        },
        config = {
            char = "│",
            use_treesitter_scope = false,
            show_trailing_blankline_indent = false,
            -- show_current_context = true,
            space_char_blankline = " ",
            use_treesitter = true,
            show_first_indent_level = false,
            buftype_exclude = { "terminal", "nofile" },
            filetype_exclude = {
                "norg",
                "alpha",
                "help",
                "neogitstatus",
                "neo-tree",
                "lazy",
                "Telescope",
            },
            context_patterns = {
                "^for",
                "^func",
                "^if",
                "^object",
                "^table",
                "^while",
                "argument_list",
                "arguments",
                "block",
                "catch_clause",
                "class",
                "dictionary",
                "do_block",
                "element",
                "else_clause",
                "except",
                "for",
                "function",
                "if_statement",
                "import_statement",
                "method",
                "object",
                "operation_type",
                "return",
                "table",
                "try",
                "try_statement",
                "tuple",
                "while",
                "with",
            },
        },
    },
}
