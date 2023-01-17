return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = {
        "m-demare/hlargs.nvim",
        config = true,
        --     color = cp.red,
        -- },
    },
    config = function()
        local catppuccin = require "catppuccin"
        catppuccin.setup {
            flavour = "frappe", -- Can be one of: latte, frappe, macchiato, mocha
            term_colors = true,
            -- no_italic = true,
            -- no_bold = true,
            styles = {
                comments = { "italic" },
                properties = { "italic" },
                functions = { "italic", "bold" },
                keywords = { "italic" },
                operators = { "bold" },
                conditionals = { "bold" },
                loops = { "bold" },
                booleans = { "bold", "italic" },
                numbers = {},
                types = {},
                strings = {},
                variables = { "bold" },
            },
            color_overrides = {
                frappe = {
                    rosewater = "#F4DBD6",
                    flamingo = "#F0C6C6",
                    pink = "#d3869b",
                    mauve = "#ab6c7d",
                    red = "#ea6962",
                    maroon = "#bd6f3e",
                    peach = "#e78a4e",
                    yellow = "#d8a657",
                    green = "#a9b665",
                    teal = "#89b482",
                    sky = "#7daea3",
                    sapphire = "#7DC4E4",
                    blue = "#458588",
                    lavender = "#83a598",
                    text = "#ddc7a1",
                    subtext1 = "#d4be98",
                    subtext0 = "#c5b18d",
                    overlay2 = "#a89984",
                    overlay1 = "#928374",
                    overlay0 = "#7c6f64",
                    surface2 = "#665c54",
                    surface1 = "#5a524c",
                    surface0 = "#45403d",
                    base = "#32302f",
                    mantle = "#292828",
                    crust = "#202121",
                },
            },
            highlight_overrides = {
                frappe = function(cp)
                    return {
                        -- For base configs.
                        CursorLineNr = { fg = cp.green },
                        Search = { bg = cp.surface1, fg = cp.pink, style = { "bold" } },
                        IncSearch = { bg = cp.pink, fg = cp.surface1 },

                        -- For native lsp configs.
                        DiagnosticVirtualTextError = { bg = cp.none },
                        DiagnosticVirtualTextWarn = { bg = cp.none },
                        DiagnosticVirtualTextInfo = { bg = cp.none },
                        DiagnosticVirtualTextHint = { fg = cp.rosewater, bg = cp.none },

                        DiagnosticHint = { fg = cp.rosewater },
                        LspDiagnosticsDefaultHint = { fg = cp.rosewater },
                        LspDiagnosticsHint = { fg = cp.rosewater },
                        LspDiagnosticsVirtualTextHint = { fg = cp.rosewater },
                        LspDiagnosticsUnderlineHint = { sp = cp.rosewater },

                        -- For hlargs
                        Hlargs = { fg = cp.peach, style = { "bold" } },

                        -- For MatchParen
                        MatchParen = { fg = cp.red, bg = cp.text, style = { "bold" } },

                        -- For fidget.
                        FidgetTask = { bg = cp.none, fg = cp.surface2 },
                        FidgetTitle = { fg = cp.blue, style = { "bold" } },
                        -- Function = { fg = cp.red },

                        -- For treesitter.
                        -- ["@field"] = { fg = cp.rosewater },
                        -- ["@property"] = { fg = cp.yellow },
                        -- ["declaration"] = { style = { "bold", "italic" } },

                        ["@include"] = { fg = cp.pink },
                        -- ["@operator"] = { fg = cp.sky },
                        -- ["@keyword.operator"] = { fg = cp.sky },
                        -- ["@punctuation.special"] = { fg = cp.maroon },

                        -- ["@float"] = { fg = cp.peach },
                        -- ["@number"] = { fg = cp.peach },
                        -- ["@boolean"] = { fg = cp.peach },

                        ["@constructor"] = { fg = cp.sky },
                        -- ["@constant"] = { fg = cp.peach },
                        ["@conditional"] = { fg = cp.red },
                        ["@repeat"] = { fg = cp.pink, style = {} },
                        ["@exception"] = { fg = cp.pink, style = {} },

                        -- ["@constant.builtin"] = { fg = cp.lavender },
                        -- ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
                        -- ["@type.builtin"] = { fg = cp.subtext1, style = { "italic" } },
                        ["@variable.builtin"] = { fg = cp.peach, style = { "italic" } },

                        ["@function"] = { fg = cp.green, style = {} },
                        -- ["@function.macro"] = { fg = cp.peach, style = {} },
                        ["@parameter"] = { fg = cp.peach, style = { "bold" } },
                        ["@keyword"] = { fg = cp.pink, style = {} },
                        ["@keyword.function"] = { fg = cp.yellow },
                        ["@keyword.return"] = { fg = cp.pink, style = {} },

                        -- ["@text.note"] = { fg = cp.base, bg = cp.blue },
                        -- ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
                        -- ["@text.danger"] = { fg = cp.base, bg = cp.red },
                        -- ["@constant.macro"] = { fg = cp.mauve },

                        -- ["@label"] = { fg = cp.blue },
                        ["@method"] = { fg = cp.blue, style = { "italic" } },
                        -- ["@namespace"] = { fg = cp.rosewater, style = {} },

                        -- ["@punctuation.delimiter"] = { fg = cp.teal },
                        -- ["@punctuation.bracket"] = { fg = cp.overlay2 },
                        -- ["@string"] = { fg = cp.subtext0 },
                        -- ["@string.regex"] = { fg = cp.peach },
                        ["@type.qualifier"] = { fg = cp.pink },
                        ["@type"] = { fg = cp.sky },
                        -- ["@variable"] = { fg = cp.text, style = { "bold" } },
                        -- ["@tag.attribute"] = { fg = cp.mauve, style = { "italic" } },
                        -- ["@tag"] = { fg = cp.peach },
                        -- ["@tag.delimiter"] = { fg = cp.maroon },
                        -- ["@text"] = { fg = cp.text },

                        -- ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
                        -- ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
                        -- ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
                        -- ["@text.title"] = { fg = cp.blue, style = { "bold" } },
                        -- ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
                        -- ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
                        -- ["@string.escape"] = { fg = cp.pink },

                        -- ["@property.toml"] = { fg = cp.blue },
                        -- ["@field.yaml"] = { fg = cp.blue },

                        -- ["@label.json"] = { fg = cp.blue },

                        -- ["@function.builtin.bash"] = { fg = cp.red, style = { "italic" } },
                        -- ["@parameter.bash"] = { fg = cp.yellow, style = { "italic" } },

                        -- ["@field.lua"] = { fg = cp.lavender },
                        -- ["@constructor.lua"] = { fg = cp.flamingo },

                        -- ["@constant.java"] = { fg = cp.teal },

                        -- ["@property.typescript"] = { fg = cp.lavender, style = { "italic" } },
                        -- ["@constructor.typescript"] = { fg = cp.lavender },

                        -- ["@constructor.tsx"] = { fg = cp.lavender },
                        -- ["@tag.attribute.tsx"] = { fg = cp.mauve },

                        -- ["@type.css"] = { fg = cp.lavender },
                        -- ["@property.css"] = { fg = cp.yellow, style = { "italic" } },

                        -- ["@property.cpp"] = { fg = cp.text },

                        -- ["@symbol"] = { fg = cp.flamingo },
                    }
                end,
            },
            integrations = {
                treesitter = true,
                mason = true,
                cmp = true,
                telescope = true,
                fidget = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                },
                notify = true,
                mini = true,
                gitsigns = true,
                illuminate = true,
                symbols_outline = true,
                ts_rainbow = true,
                semantic_tokens = true,
                noice = true,
                neotree = true,
                leap = true,
                indent_blankline = { enabled = true, colored_indent_levels = false },
                -- false
                dap = { enabled = false, enable_ui = false },
                aerial = false,
                navic = { enabled = false },
                barbar = false,
                beacon = false,
                dashboard = false,
                fern = false,
                harpoon = false,
                hop = false,
                lightspeed = false,
                markdown = false,
                neogit = false,
                neotest = false,
                treesitter_context = false,
                overseer = false,
                pounce = false,
                telekasten = false,
                lsp_trouble = false,
                gitgutter = false,
                vim_sneak = false,
                vimwiki = false,
                which_key = false,
                nvimtree = false,
                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
        }

        vim.cmd.colorscheme "catppuccin"
    end,
}
