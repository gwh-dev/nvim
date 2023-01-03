return {
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
        "monkoose/matchparen.nvim",
        event = "VeryLazy",
        config = true,
    },

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },
}
