return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = "all",
            sync_install = false,
            auto_install = false,

            autopairs = { enable = true },
            highlight = { enable = true },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
        }
    end,
}
