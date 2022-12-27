-- require("onedarkpro").setup {
--     plugins = { -- Override which plugin highlight groups are loaded
--         leap = true,
--         neo_tree = true,
--         nvim_cmp = true,
--         native_lsp = true,
--         nvim_navic = true,
--         packer = true,
--         telescope = true,
--         treesitter = true,
--         -- disable
--         op_nvim = false,
--         trouble = false,
--         vim_ultest = false,
--         which_key = false,
--         toggleterm = false,
--         polygot = false,
--         nvim_ts_rainbow = false,
--         startify = false,
--         nvim_tree = false,
--         nvim_notify = false,
--         nvim_hlslens = false,
--         nvim_dap_ui = false,
--         nvim_dap = false,
--         nvim_bqf = false,
--         neotest = false,
--         marks = false,
--         lsp_saga = false,
--         aerial = false,
--         barbar = false,
--         copilot = false,
--         dashboard = false,
--         gitsigns = false,
--         glance = false,
--         hop = false,
--         indentline = false,
--     },
--     options = {
--         bold = false, -- Use bold styles?
--         italic = true, -- Use italic styles?
--         underline = true, -- Use underline styles?
--         undercurl = true, -- Use undercurl styles?

--         cursorline = false, -- Use cursorline highlighting?
--         transparency = false, -- Use a transparent background?
--         terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
--         highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
--     },
-- }
require("material").setup {

    contrast = {
        terminal = false, -- Enable contrast for the built-in terminal
        sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = true, -- Enable contrast for floating windows
        cursor_line = true, -- Enable darker background for the cursor line
        non_current_windows = false, -- Enable darker background for non-current windows
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
        -- Available plugins:
        -- "dap",
        -- "dashboard",
        -- "gitsigns",
        -- "hop",
        -- "indent-blankline",
        -- "lspsaga",
        -- "mini",
        -- "neogit",
        "nvim-cmp",
        "nvim-navic",
        -- "nvim-tree",
        "nvim-web-devicons",
        -- "sneak",
        "telescope",
        -- "trouble",
        -- "which-key",
    },

    disable = {
        colored_cursor = true, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = true, -- Prevent the theme from setting terminal colors
        eob_lines = false, -- Hide the end-of-buffer lines
    },

    high_visibility = {
        darker = true, -- Enable higher contrast text for darker style
    },

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)
}

vim.g.material_style = "deep ocean"
vim.cmd.colorscheme "material"

-- local catppuccin = require "catppuccin"

-- catppuccin.setup {
--     term_colors = true,
--     transparent_background = false,
--     no_bold = true,
--     integrations = {
--         treesitter = true,
--         mason = true,
--         cmp = true,
--         telescope = true,
--         fidget = true,
--         leap = true,
--         neotree = true,
--         native_lsp = { enabled = true },
--         navic = { enabled = true },
--         -- Disable
--         dap = { enabled = false, enable_ui = false },
--         aerial = false,
--         indent_blankline = { enabled = false },
--         barbar = false,
--         beacon = false,
--         dashboard = false,
--         fern = false,
--         harpoon = false,
--         hop = false,
--         lightspeed = false,
--         markdown = false,
--         neogit = false,
--         neotest = false,
--         noice = false,
--         semantic_tokens = false,
--         treesitter_context = false,
--         ts_rainbow = false,
--         overseer = false,
--         pounce = false,
--         symbols_outline = false,
--         telekasten = false,
--         lsp_trouble = false,
--         gitgutter = false,
--         illuminate = false,
--         vim_sneak = false,
--         vimwiki = false,
--         which_key = false,
--         gitsigns = false,
--         nvimtree = false,
--         notify = false,
--         mini = false,
--         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--     },
-- }

-- catppuccin.load "mocha"
