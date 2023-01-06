local M = {
    {
        "smjonas/inc-rename.nvim",
        event = "BufReadPre",
        config = true,
    },
    {
        "anuvyklack/windows.nvim",
        event = "WinNew",
        dependencies = {
            { "anuvyklack/middleclass" },
        },
        keys = { { "<leader>z", "<cmd>WindowsMaximize<cr>" } },
        config = function()
            vim.o.winwidth = 5
            vim.o.winminwidth = 5
            vim.o.equalalways = false
            require("windows").setup()
        end,
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
        "dnlhc/glance.nvim",
        cmd = "Glance",
        config = true,
    },

    {
        "ojroques/nvim-bufdel",
        keys = { { "<localleader>q", "<cmd>BufDel<cr>", desc = "Buffer Delete" } },
        config = true,
    },

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
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
        "simrat39/symbols-outline.nvim",
        keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
        config = true,
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true,
    },

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
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {
                check_ts = true,
                ts_config = {
                    lua = { "string", "source" },
                    javascript = { "string", "template_string" },
                    java = false,
                },
                disable_filetype = { "TelescopePrompt" },
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "Search",
                    highlight_grey = "Comment",
                },
            }
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

    -- better yank/paste
    {
        "kkharji/sqlite.lua",
        event = "BufReadPost",
        dependencies = {
            "gbprod/yanky.nvim",
        },
        config = function()
            require("yanky").setup {
                highlight = {
                    timer = 150,
                },
                ring = {
                    storage = "sqlite",
                },
            }

            vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
            vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
            vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
            vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
            vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
            vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
            vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
            -- vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
            -- vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
            -- vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
            -- vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")
            --
            -- vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
            -- vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
            -- vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
            -- vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

            vim.keymap.set("n", "]p", "<Plug>(YankyPutAfterFilter)")
            vim.keymap.set("n", "[p", "<Plug>(YankyPutBeforeFilter)")
            -- vim.keymap.set("n", "<leader>P", function()
            --     require("telescope").extensions.yank_history.yank_history {}
            -- end, { desc = "Paste from Yanky" })
        end,
    },
}

return M
