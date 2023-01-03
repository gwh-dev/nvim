return {
    {
        "ggandor/leap.nvim",
        keys = { "s", "S", "f", "F", "t", "T" },
        dependencies = {
            {
                "ggandor/flit.nvim",
                config = {
                    labeled_modes = "nv",
                },
            },
        },
        config = function()
            require("leap").add_default_mappings()
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        keys = { { "<localleader>c", "<cmd>ColorizerToggle<cr>", desc = "Colorizer" } },
        config = {
            filetypes = { "*", "!lazy" },
            buftype = { "*", "!prompt", "!nofile" },
            user_default_options = {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = false, -- "Name" codes like Blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                AARRGGBB = false, -- 0xAARRGGBB hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- Available modes: foreground, background
                -- Available modes for `mode`: foreground, background,  virtualtext
                mode = "background", -- Set the display mode.
                virtualtext = "■",
            },
        },
    },
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        keys = {
            { "gcc", mode = "n" },
            { "gbc", mode = "n" },
            { "gc", mode = "v" },
            { "gb", mode = "v" },
        },
        config = function()
            require("Comment").setup {
                ignore = "^$", -- ignore empty lines
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
    },

    {
        "ojroques/nvim-bufdel",
        keys = { { "<localleader>q", "<cmd>BufDel<cr>", desc = "Buffer Delete" } },
        config = true,
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true,
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", [[<cmd>UndotreeToggle<CR>]], { silent = true } },
        },
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
    },
    {
        "folke/trouble.nvim",
        keys = {
            { "<leader>t", "<cmd>TroubleToggle<cr>", desc = "Trouble Diagnostics" },
        },
        config = {
            auto_open = false,
            use_diagnostic_signs = true, -- en
        },
    },

    {
        "danymat/neogen",
        keys = {
            {
                "<leader>cc",
                function()
                    require("neogen").generate {}
                end,
                desc = "Neogen Comment",
            },
        },
        config = { snippet_engine = "luasnip" },
    },
    {
        "monkoose/matchparen.nvim",
        event = "VeryLazy",
        config = true,
    },

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },
}
