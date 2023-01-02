local M = {
    {
        "nvim-neorg/neorg",
        ft = "norg",
        priority = 2000,
        config = {
            load = {
                ["core.defaults"] = {},
                ["core.norg.concealer"] = {},
                ["core.norg.completion"] = {
                    config = { engine = "nvim-cmp" },
                },
                ["core.integrations.nvim-cmp"] = {},
            },
        },
    },
    {
        "phaazon/mind.nvim",
        version = "v2.2",
        keys = {
            { "<localleader>a", "<cmd>MindOpenMain<cr>", desc = "Main Note Taking Tree" },
            { "<localleader>s", "<cmd>MindOpenSmartProject<cr>", desc = "Project Note Taking Tree" },
        },
        config = {
            edit = {
                data_header = [[@document.meta\ntitle: %s\n@end]],
                data_extension = ".norg",
            },
        },
    },
}

return M
