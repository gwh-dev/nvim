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
                    copy = colors.milk,
                    delete = colors.red,
                    insert = colors.bright_yellow,
                    visual = colors.foreground,
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
                                guibg = "#3c3a39",
                                -- gui = "bold",
                            },
                            InclineNormalNC = {
                                guifg = colors.foreground,
                                guibg = "#3c3a39",
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
                normal = { fg = colors.soft_yellow, bg = "#3c3a39" },
                ellipsis = { fg = colors.soft_yellow },
                separator = { fg = colors.pink },
                modified = { fg = colors.light_blue },
                dirname = { fg = colors.blue_gray },
                basename = { fg = colors.soft_yellow, bold = true },
                context = { fg = colors.milk },
            },
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = {
            options = {
                icons_enabled = true,
                globalstatus = true,
                component_separators = {},
                disabled_filetypes = { statusline = { "alpha", "lazy" } },
                refresh = {
                    statusline = 500,
                    tabline = nil,
                    winbar = nil,
                },
            },
            sections = {
                lualine_a = { { "mode", separator = { left = "", right = "" } } },
                lualine_b = { "branch" },
                lualine_c = {
                    { require("core.utils").lsp_client, icon = " " },
                    { "diagnostics", sources = { "nvim_diagnostic" } },
                },
                lualine_x = {
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
                lualine_z = { { "filesize", separator = { left = "", right = "" } } },
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
        },
    },
}
