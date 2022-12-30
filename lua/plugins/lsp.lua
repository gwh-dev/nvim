return {
    'VonHeikemen/lsp-zero.nvim',
    event = "BufReadPre",
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },


        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()

        local lsp = require('lsp-zero')
        lsp.preset('recommended')

        lsp.ensure_installed({
            'tsserver',
            'eslint',
            'sumneko_lua',
            'rust_analyzer',
            'gopls',
        })

        lsp.on_attach(function(client, bufnr)
            require("nvim-navic").attach(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
            local map = vim.keymap.set
            map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        end)

        lsp.set_preferences({
            sign_icons = {}
        })

        lsp.setup()

    end
}
