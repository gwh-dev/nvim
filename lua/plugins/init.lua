return {
    -- essentials
    { "MunifTanjim/nui.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons", config = { default = true } },

    -- Motions
    {
        "ggandor/leap.nvim",
        keys = { "s", "S", "f", "F", "t", "T" },
        dependencies = {
            "tpope/vim-repeat",
            {
                "ggandor/flit.nvim",
                config = function()
                    require("flit").setup({ labeled_modes = "nv" })
                end,
            },
        },
        config = function()
            require("leap").add_default_mappings()
        end,
    },

    -- Utils
    {
        "ojroques/nvim-bufdel",
        cmd = "BufDel",
        keys = { { "<localleader>q", "<cmd>BufDel<cr>", desc = "Buffer Delete", { silent = true } } },
        config = function()
            require("bufdel").setup()
        end,
    },

    -- Commenting
    {
        "numToStr/Comment.nvim",
        dependencies = {
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
        keys = {
            { "gcc", mode = "n" },
            { "gbc", mode = "n" },
            { "gc", mode = "v" },
            { "gb", mode = "v" },
        },
        config = function()
            require("Comment").setup({
                ignore = "^$", -- ignore empty lines
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },

    -- utils
    {
        "monkoose/matchparen.nvim",
        event = "BufReadPost",
        config = function()
            require("matchparen").setup()
        end,
    },

    {
        "kylechui/nvim-surround",
        event = "BufReadPost",
        version = "*",
        config = function()
            require("nvim-surround").setup()
        end,
    },

    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
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
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },
}
