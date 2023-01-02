return {
    "olimorris/onedarkpro.nvim",
    event = "VeryLazy",
    config = function()
        local onedarkpro = require "onedarkpro"
        onedarkpro.setup {
            plugins = {
                leap = true,
                neo_tree = true,
                nvim_cmp = true,
                native_lsp = true,
                nvim_navic = true,
                telescope = true,
                treesitter = true,
                gitsigns = true,
                -- disable
                indentline = false,
                trouble = false,
                nvim_dap_ui = false,
                nvim_dap = false,
                packer = false,
                op_nvim = false,
                vim_ultest = false,
                which_key = false,
                toggleterm = false,
                polygot = false,
                nvim_ts_rainbow = false,
                startify = false,
                nvim_tree = false,
                nvim_hlslens = false,
                nvim_bqf = false,
                neotest = false,
                nvim_notify = false,
                marks = false,
                lsp_saga = false,
                aerial = false,
                barbar = false,
                copilot = false,
                dashboard = false,
                hop = false,
            },
            options = {
                bold = false, -- Use bold styles?
                cursorline = true, -- Use cursorline highlighting?
            },
        }
        onedarkpro.load()
    end,
}
