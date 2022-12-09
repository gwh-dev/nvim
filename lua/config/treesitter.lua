local cmd = vim.cmd
cmd("packadd nvim-treesitter-refactor")
cmd("packadd nvim-ts-context-commentstring")

require("nvim-treesitter.configs").setup({
    -- ensure_installed = "all"
    -- auto_install = true,
    -- sync_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = false },
    refactor = {
        smart_rename = { enable = true, keymaps = { smart_rename = "grr" } },
        highlight_definitions = { enable = true },
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    -- autopairs = { enable = true },
})
