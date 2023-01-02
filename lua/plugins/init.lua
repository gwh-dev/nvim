return {
    -- Essentials
    { "lewis6991/impatient.nvim" },
    { "MunifTanjim/nui.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons", config = { default = true } },

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
        "folke/trouble.nvim",
        keys = {
            { "<leader>t", "<cmd>TroubleToggle<cr>", desc = "Trouble Diagnostics" },
        },
        config = {
            auto_open = false,
            use_diagnostic_signs = true, -- en
        },
    },

    -- Commenting
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

    -- utils
    {
        "ojroques/nvim-bufdel",
        keys = { { "<localleader>q", "<cmd>BufDel<cr>", desc = "Buffer Delete" } },
        config = true,
    },

    {
        "monkoose/matchparen.nvim",
        event = "VeryLazy",
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

    -- Profiler
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },
}
