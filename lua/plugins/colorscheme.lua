-- Trying a lot of colors
local M = {
    -- "olimorris/onedarkpro.nvim",
    -- event = "BufReadPre",
    -- ft = "alpha",
    -- priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function()
    --     local onedarkpro = require "onedarkpro"
    --     onedarkpro.setup {
    --         highlights = {
    --             -- CursorColumn = {
    --             --     bg = "${cursorline}",
    --             -- },
    --             MiniIndentscopeSymbol = {
    --                 fg = "${purple}",
    --             },
    --         },
    --         plugins = {
    --             leap = true,
    --             neo_tree = true,
    --             nvim_cmp = true,
    --             native_lsp = true,
    --             nvim_navic = true,
    --             telescope = true,
    --             treesitter = true,
    --             gitsigns = true,
    --             indentline = true,
    --             dashboard = true,
    --             -- disable
    --             nvim_notify = false,
    --             barbar = false,
    --             trouble = false,
    --             nvim_dap_ui = false,
    --             nvim_dap = false,
    --             packer = false,
    --             op_nvim = false,
    --             vim_ultest = false,
    --             which_key = false,
    --             toggleterm = false,
    --             polygot = false,
    --             nvim_ts_rainbow = false,
    --             startify = false,
    --             nvim_tree = false,
    --             nvim_hlslens = false,
    --             nvim_bqf = false,
    --             neotest = false,
    --             marks = false,
    --             lsp_saga = false,
    --             aerial = false,
    --             copilot = false,
    --             hop = false,
    --         },
    --         options = {
    --             bold = false, -- Use bold styles?
    --             cursorline = true, -- Use cursorline highlighting?
    --         },
    --     }
    --     onedarkpro.load()
    -- end,
    -- "rebelot/kanagawa.nvim",
    -- "olimorris/onedarkpro.nvim",
    -- "catppuccin/nvim",
    -- "rafi/awesome-vim-colorschemes",
    -- "sainnhe/gruvbox-material",
    "luisiacc/gruvbox-baby",
    -- "echasnovski/mini.base16",
    -- "marko-cerovac/material.nvim",
    -- "Iron-E/nvim-highlite",
    -- "rose-pine/neovim",
    -- name = "rose-pine",
    event = "BufRead",
    -- event = "BufReadPre",
    branch = "main",
}

function M.config()
    -- vim.cmd.colorscheme "kanagawa"
    -- require("catppuccin").setup {
    --     flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
    --     background = { light = "latte", dark = "mocha" },
    --     no_bold = true, -- Force no bold
    --     dim_inactive = {
    --         enabled = false,
    --         shade = "dark",
    --         percentage = 0.15,
    --     },
    --     transparent_background = false,
    --     term_colors = true,
    --     compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
    --     styles = {
    --         comments = { "italic" },
    --         properties = { "italic" },
    --         functions = { "italic" },
    --         keywords = { "italic" },
    --         -- operators = { "bold" },
    --         -- conditionals = { "bold" },
    --         -- loops = { "bold" },
    --         booleans = { "italic" },
    --         numbers = {},
    --         types = {},
    --         strings = {},
    --         variables = {},
    --     },
    --     integrations = {
    --         treesitter = true,
    --         native_lsp = {
    --             enabled = true,
    --             virtual_text = {
    --                 errors = { "italic" },
    --                 hints = { "italic" },
    --                 warnings = { "italic" },
    --                 information = { "italic" },
    --             },
    --             underlines = {
    --                 errors = { "underline" },
    --                 hints = { "underline" },
    --                 warnings = { "underline" },
    --                 information = { "underline" },
    --             },
    --         },
    --         lsp_trouble = false,
    --         lsp_saga = false,
    --         gitgutter = false,
    --         gitsigns = true,
    --         telescope = true,
    --         nvimtree = false,
    --         which_key = false,
    --         indent_blankline = { enabled = true, colored_indent_levels = false },
    --         dashboard = false,
    --         neogit = false,
    --         vim_sneak = false,
    --         fern = false,
    --         barbar = false,
    --         markdown = false,
    --         lightspeed = false,
    --         ts_rainbow = false,
    --         mason = true,
    --         neotest = false,
    --         noice = false,
    --         hop = false,
    --         illuminate = false,
    --         cmp = true,
    --         dap = { enabled = false, enable_ui = false },
    --         notify = true,
    --         symbols_outline = true,
    --         coc_nvim = false,
    --         leap = true,
    --         neotree = { enabled = true, show_root = false, transparent_panel = false },
    --         telekasten = false,
    --         mini = false,
    --         aerial = false,
    --         vimwiki = false,
    --         beacon = false,
    --         navic = { enabled = true },
    --         overseer = false,
    --         fidget = true,
    --     },
    --     color_overrides = {
    --         mocha = {
    --             rosewater = "#F5E0DC",
    --             flamingo = "#F2CDCD",
    --             mauve = "#DDB6F2",
    --             pink = "#F5C2E7",
    --             red = "#F28FAD",
    --             maroon = "#E8A2AF",
    --             peach = "#F8BD96",
    --             yellow = "#FAE3B0",
    --             green = "#ABE9B3",
    --             blue = "#96CDFB",
    --             sky = "#89DCEB",
    --             teal = "#B5E8E0",
    --             lavender = "#C9CBFF",

    --             text = "#D9E0EE",
    --             subtext1 = "#BAC2DE",
    --             subtext0 = "#A6ADC8",
    --             overlay2 = "#C3BAC6",
    --             overlay1 = "#988BA2",
    --             overlay0 = "#6E6C7E",
    --             surface2 = "#6E6C7E",
    --             surface1 = "#575268",
    --             surface0 = "#302D41",

    --             base = "#1E1E2E",
    --             mantle = "#1A1826",
    --             crust = "#161320",
    --         },
    --     },
    --     highlight_overrides = {
    --         mocha = function(cp)
    --             return {
    --                 -- For base configs.
    --                 CursorLineNr = { fg = cp.green },
    --                 Search = { bg = cp.surface1, fg = cp.pink, style = { "bold" } },
    --                 IncSearch = { bg = cp.pink, fg = cp.surface1 },

    --                 -- For native lsp configs.
    --                 DiagnosticVirtualTextError = { bg = cp.none },
    --                 DiagnosticVirtualTextWarn = { bg = cp.none },
    --                 DiagnosticVirtualTextInfo = { bg = cp.none },
    --                 DiagnosticVirtualTextHint = { fg = cp.rosewater, bg = cp.none },

    --                 DiagnosticHint = { fg = cp.rosewater },
    --                 LspDiagnosticsDefaultHint = { fg = cp.rosewater },
    --                 LspDiagnosticsHint = { fg = cp.rosewater },
    --                 LspDiagnosticsVirtualTextHint = { fg = cp.rosewater },
    --                 LspDiagnosticsUnderlineHint = { sp = cp.rosewater },

    --                 -- For fidget.
    --                 FidgetTask = { bg = cp.none, fg = cp.surface2 },
    --                 FidgetTitle = { fg = cp.blue, style = { "bold" } },

    --                 -- For treesitter.
    --                 ["@field"] = { fg = cp.rosewater },
    --                 ["@property"] = { fg = cp.yellow },

    --                 ["@include"] = { fg = cp.teal },
    --                 ["@operator"] = { fg = cp.sky },
    --                 ["@keyword.operator"] = { fg = cp.sky },
    --                 ["@punctuation.special"] = { fg = cp.maroon },

    --                 -- ["@float"] = { fg = cp.peach },
    --                 -- ["@number"] = { fg = cp.peach },
    --                 -- ["@boolean"] = { fg = cp.peach },

    --                 ["@constructor"] = { fg = cp.lavender },
    --                 -- ["@constant"] = { fg = cp.peach },
    --                 -- ["@conditional"] = { fg = cp.mauve },
    --                 -- ["@repeat"] = { fg = cp.mauve },
    --                 ["@exception"] = { fg = cp.peach },

    --                 ["@constant.builtin"] = { fg = cp.lavender },
    --                 -- ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
    --                 -- ["@type.builtin"] = { fg = cp.yellow, style = { "italic" } },
    --                 ["@variable.builtin"] = { fg = cp.red, style = { "italic" } },

    --                 -- ["@function"] = { fg = cp.blue },
    --                 ["@function.macro"] = { fg = cp.red, style = {} },
    --                 ["@parameter"] = { fg = cp.rosewater },
    --                 ["@keyword.function"] = { fg = cp.maroon },
    --                 ["@keyword"] = { fg = cp.red },
    --                 ["@keyword.return"] = { fg = cp.pink, style = {} },

    --                 -- ["@text.note"] = { fg = cp.base, bg = cp.blue },
    --                 -- ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
    --                 -- ["@text.danger"] = { fg = cp.base, bg = cp.red },
    --                 -- ["@constant.macro"] = { fg = cp.mauve },

    --                 -- ["@label"] = { fg = cp.blue },
    --                 ["@method"] = { style = { "italic" } },
    --                 ["@namespace"] = { fg = cp.rosewater, style = {} },

    --                 ["@punctuation.delimiter"] = { fg = cp.teal },
    --                 ["@punctuation.bracket"] = { fg = cp.overlay2 },
    --                 -- ["@string"] = { fg = cp.green },
    --                 -- ["@string.regex"] = { fg = cp.peach },
    --                 -- ["@type"] = { fg = cp.yellow },
    --                 ["@variable"] = { fg = cp.text },
    --                 ["@tag.attribute"] = { fg = cp.mauve, style = { "italic" } },
    --                 ["@tag"] = { fg = cp.peach },
    --                 ["@tag.delimiter"] = { fg = cp.maroon },
    --                 ["@text"] = { fg = cp.text },

    --                 -- ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
    --                 -- ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
    --                 -- ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
    --                 -- ["@text.title"] = { fg = cp.blue, style = { "bold" } },
    --                 -- ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
    --                 -- ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
    --                 -- ["@string.escape"] = { fg = cp.pink },

    --                 -- ["@property.toml"] = { fg = cp.blue },
    --                 -- ["@field.yaml"] = { fg = cp.blue },

    --                 -- ["@label.json"] = { fg = cp.blue },

    --                 ["@function.builtin.bash"] = { fg = cp.red, style = { "italic" } },
    --                 ["@parameter.bash"] = { fg = cp.yellow, style = { "italic" } },

    --                 ["@field.lua"] = { fg = cp.lavender },
    --                 ["@constructor.lua"] = { fg = cp.flamingo },

    --                 ["@constant.java"] = { fg = cp.teal },

    --                 ["@property.typescript"] = { fg = cp.lavender, style = { "italic" } },
    --                 -- ["@constructor.typescript"] = { fg = cp.lavender },

    --                 -- ["@constructor.tsx"] = { fg = cp.lavender },
    --                 -- ["@tag.attribute.tsx"] = { fg = cp.mauve },

    --                 ["@type.css"] = { fg = cp.lavender },
    --                 ["@property.css"] = { fg = cp.yellow, style = { "italic" } },

    --                 ["@property.cpp"] = { fg = cp.text },

    --                 -- ["@symbol"] = { fg = cp.flamingo },
    --             }
    --         end,
    --     },
    -- }
    -- require("catppuccin").load()
    -- vim.g.gruvbox_material_better_performance = 1
    -- vim.g.gruvbox_material_background = "soft" -- hard, soft default: medium
    -- vim.g.gruvbox_material_foreground = "mix"
    -- vim.g.gruvbox_material_sign_column_background = "grey"
    -- vim.cmd.colorscheme "gruvbox-material"
    -- require("mini.base16").setup {
    --     palette = {
    --         -- Gruvbox material
    --         base00 = "#292828",
    --         base01 = "#32302f",
    --         base02 = "#504945",
    --         base03 = "#665c54",
    --         base04 = "#bdae93",
    --         base05 = "#d4be98",
    --         base06 = "#ebdbb2",
    --         base07 = "#fbf1c7",
    --         base08 = "#ea6962",
    --         base09 = "#e78a4e",
    --         base0A = "#d8a657",
    --         base0B = "#a9b665",
    --         base0C = "#89b482",
    --         base0D = "#7daea3",
    --         base0E = "#d3869b",
    --         base0F = "#bd6f3e",
    --     },

    --     plugins = { default = true },
    -- }
    -- vim.cmd.colorscheme "highlite"
    -- vim.g.material_style = "darker"
    -- require("material").setup {
    --     contrast = {
    --         sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
    --         floating_windows = true, -- Enable contrast for floating windows
    --         cursor_line = false, -- Enable darker background for the cursor line
    --     },
    --     styles = { -- Give comments style such as bold, italic, underline etc.
    --         strings = { bold = false },
    --         functions = { bold = false },
    --     },

    --     plugins = { -- Uncomment the plugins that you use to highlight them
    --         "gitsigns",
    --         "indent-blankline",
    --         "nvim-cmp",
    --         "nvim-navic",
    --         "nvim-web-devicons",
    --         "telescope",
    --     },
    -- }
    -- vim.cmd.colorscheme "material"
    -- require("rose-pine").setup {
    --     disable_background = true,
    --     disable_float_background = true,
    -- }
    -- vim.cmd.colorscheme "rose-pine"
    vim.g.gruvbox_baby_function_style = "NONE"
    vim.g.gruvbox_baby_telescope_theme = 1
    vim.g.gruvbox_baby_highlights = {
        -- NavicIconsFile = { bg = "NONE", fg = "#" },
        -- NavicIconsModule = { bg = "NONE", fg = "#" },
        -- NavicIconsNamespace = { bg = "NONE", fg = "#" },
        -- NavicIconsPackage = { bg = "NONE", fg = "#" },
        -- NavicIconsClass = { bg = "NONE", fg = "#" },
        -- NavicIconsMethod = { bg = "NONE", fg = "#" },
        -- NavicIconsProperty = { bg = "NONE", fg = "#" },
        -- NavicIconsField = { bg = "NONE", fg = "#" },
        -- NavicIconsConstructor = { bg = "NONE", fg = "#" },
        -- NavicIconsEnum = { bg = "NONE", fg = "#" },
        -- NavicIconsInterface = { bg = "NONE", fg = "#" },
        -- NavicIconsFunction = { bg = "NONE", fg = "#" },
        -- NavicIconsVariable = { bg = "NONE", fg = "#" },
        -- NavicIconsConstant = { bg = "NONE", fg = "#" },
        -- NavicIconsString = { bg = "NONE", fg = "#" },
        -- NavicIconsNumber = { bg = "NONE", fg = "#" },
        -- NavicIconsBoolean = { bg = "NONE", fg = "#" },
        -- NavicIconsArray = { bg = "NONE", fg = "#" },
        -- NavicIconsObject = { bg = "NONE", fg = "#" },
        -- NavicIconsKey = { bg = "NONE", fg = "#" },
        -- NavicIconsNull = { bg = "NONE", fg = "#" },
        -- NavicIconsEnumMember = { bg = "NONE", fg = "#" },
        -- NavicIconsStruct = { bg = "NONE", fg = "#" },
        -- NavicIconsEvent = { bg = "NONE", fg = "#" },
        -- NavicIconsOperator = { bg = "NONE", fg = "#" },
        -- NavicIconsTypeParameter = { bg = "NONE", fg = "#" },
        -- NavicText = { bg = "NONE", fg = "#" },
        -- NavicSeparator = { bg = "NONE", fg = "#" },

        -- SignColumn = { bg = "#32302f" },
        -- CursorLineNr = { bg = "#32302f" },
        -- GitSignsChange = { bg = "#32302f", fg = "#fabd2f" },
        -- GitSignsAdd = { bg = "#32302f", fg = "#8ec07c" },
        -- GitSignsDelete = { bg = "#32302f", fg = "#fb4934" },
        -- GitSignsChangeDelete = { bg = "#32302f", fg = "#eebd35" },
        -- GitSignsUntracked = { bg = "#32302f", fg = "#689d6a" },
        -- DiagnosticSignWarn = { bg = "#32302f", fg = "#eebd35" },
        -- DiagnosticSignError = { bg = "#32302f", fg = "#cc241d" },
        -- DiagnosticSignInfo = { bg = "#32302f", fg = "#7fa2ac" },
        -- DiagnosticSignHint = { bg = "#32302f", fg = "#dedede" },
    }
    vim.cmd.colorscheme "gruvbox-baby"
end
return M
