return {
    "olimorris/onedarkpro.nvim",
    event = "BufReadPre",
    -- ft = "alpha",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        local onedarkpro = require "onedarkpro"
        onedarkpro.setup {
            highlights = {
                CursorColumn = {
                    bg = "${cursorline}",
                },
                MiniIndentscopeSymbol = {
                    fg = "${purple}",
                },
            },
            plugins = {
                leap = true,
                neo_tree = true,
                nvim_cmp = true,
                native_lsp = true,
                nvim_navic = true,
                telescope = true,
                treesitter = true,
                gitsigns = true,
                indentline = true,
                -- disable
                barbar = false,
                trouble = false,
                dashboard = false,
                nvim_dap_ui = false,
                nvim_dap = false,
                nvim_notify = false,
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
                marks = false,
                lsp_saga = false,
                aerial = false,
                copilot = false,
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
