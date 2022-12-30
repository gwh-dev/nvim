return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {

            ensure_installed = {
                "vim",
                "lua",
                "rust",
                "cpp",
                "c",
                "go",
                "gomod",
                "gowork",
            },
            auto_install = true,
            sync_install = false,

            autopairs = { enable = true },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
        }
    end
}
