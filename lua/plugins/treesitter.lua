return {
    -- {
    --     "sheerun/vim-polyglot",
    --     lazy = false,
    --     config = function()
    --         vim.cmd [[syntax on]]
    --         -- vim.cmd [[syntax enable]]
    --     end,
    -- },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        build = ":TSUpdate",
        dependencies = {
            "p00f/nvim-ts-rainbow",
        },
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = "all",
                sync_install = false,
                auto_install = false,

                highlight = { enable = true },
                indent = { enable = true },
                rainbow = {
                    enable = true,
                    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                },
                autopairs = { enable = true },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
            }
        end,
    },
}
