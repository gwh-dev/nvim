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
        {
            "monkoose/matchparen.nvim",
            event = "VeryLazy",
            config = true,
        },

        {
            "RRethy/vim-illuminate",
            event = "VeryLazy",
            config = function()
                require("illuminate").configure()
            end,
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
            "akinsho/nvim-bufferline.lua",
            event = "BufAdd",
            config = {
                options = {
                    -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
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
            "b0o/incline.nvim",
            event = "BufReadPre",
            config = function()
                require("incline").setup {
                    -- highlight = {
                    --     groups = {
                    --         InclineNormal = {
                    --             -- guifg = colors.orange,
                    --             -- guibg = "#3c3a39",
                    --             -- gui = "bold",
                    --         },
                    --         InclineNormalNC = {
                    --             guifg = colors.foreground,
                    --             -- guibg = "#3c3a39",
                    --         },
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
            -- theme = "catppuccin",
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
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "catppuccin",
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
                    { lsp_client, icon = " " },
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
