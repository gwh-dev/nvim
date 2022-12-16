local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
    return
end
catppuccin.setup {
    term_colors = true,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.1,
    },
    integrations = {
        treesitter = true,
        mason = true,
        cmp = true,
        telescope = true,
        fidget = true,
        native_lsp = { enabled = true },
        --
        dap = { enabled = false, enable_ui = false },
        aerial = false,
        navic = { enabled = false },
        indent_blankline = { enabled = false },
        barbar = false,
        beacon = false,
        dashboard = false,
        fern = false,
        harpoon = false,
        hop = false,
        leap = false,
        lightspeed = false,
        markdown = false,
        neotree = false,
        neogit = false,
        neotest = false,
        noice = false,
        semantic_tokens = false,
        treesitter_context = false,
        ts_rainbow = false,
        overseer = false,
        pounce = false,
        symbols_outline = false,
        telekasten = false,
        lsp_trouble = false,
        gitgutter = false,
        illuminate = false,
        vim_sneak = false,
        vimwiki = false,
        which_key = false,
        gitsigns = false,
        nvimtree = false,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
}
catppuccin.load "frappe"
