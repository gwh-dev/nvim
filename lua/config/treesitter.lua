require("nvim-treesitter.configs").setup {
    ensure_installed = "all",
    indent = { enable = false },
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
