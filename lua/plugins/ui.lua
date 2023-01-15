local colors = require("gruvbox-baby.colors").config()

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

        {
            "mvllow/modes.nvim",
            event = "VeryLazy",
            config = {
                colors = {
                    copy = "#ddc7a1",
                    delete = "#ea6962",
                    insert = "#7daea3",
                    visual = "#d4879c",
                },
                ignore_filetypes = { "neo-tree", "TelescopePrompt" },
            },
        },

        {
            "akinsho/nvim-bufferline.lua",
            event = "BufAdd",
            config = {
                options = {
                    diagnostics = "nvim_lsp",
                    always_show_bufferline = false,
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
                require("incline").setup {
                    highlight = {
                        groups = {
                            InclineNormal = {
                                guifg = colors.orange,
                                guibg = "none",
                                -- gui = "bold",
                            },
                            InclineNormalNC = {
                                guifg = colors.foreground,
                                guibg = "none",
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

    {
        "utilyre/barbecue.nvim",
        event = "BufReadPre",
        init = function()
            vim.g.navic_silence = true
            require("core.utils").on_attach(function(client, buffer)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, buffer)
                end
            end)
        end,
        dependencies = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = {
            create_autocmd = false, -- prevent barbecue from updating itself automatically
            show_modified = true,
            kinds = {
                File = "file",
                Module = "module",
                Namespace = "namespace",
                Package = "package",
                Class = "class",
                Method = "method",
                Property = "property",
                Field = "field",
                Constructor = "constructor",
                Enum = "enum",
                Interface = "interface",
                Function = "function",
                Variable = "variable",
                Constant = "constant",
                String = "string",
                Number = "number",
                Boolean = "boolean",
                Array = "array",
                Object = "object",
                Key = "key",
                Null = "null",
                EnumMember = "enum member",
                Struct = "struct",
                Event = "event",
                Operator = "operator",
                TypeParameter = "type parameter",
            },
            theme = {
                normal = { fg = colors.soft_yellow, bg = "none" },
                ellipsis = { fg = colors.soft_yellow },
                separator = { fg = colors.pink },
                modified = { fg = colors.light_blue },
                dirname = { fg = colors.blue_gray },
                basename = { fg = colors.soft_yellow, bold = true },
                context = { fg = colors.milk },
            },
        },
    },
}
