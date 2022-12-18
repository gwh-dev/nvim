local M = {}

function M.plugins(use)
    use { "ellisonleao/gruvbox.nvim" } -- Colorscheme
    -- use { "stevearc/dressing.nvim" }

    -- Utils
    use {
        "ojroques/nvim-bufdel",
        cmd = "BufDel",
        config = [[require("bufdel").setup()]],
    }

    use {
        "monkoose/matchparen.nvim",
        event = "BufRead",
        config = [[require("matchparen").setup()]],
    }

    use {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
    }

    -- LSP Support
    use { "neovim/nvim-lspconfig", opt = true }
    use { "jose-elias-alvarez/null-ls.nvim", opt = true }
    use { "williamboman/mason.nvim", opt = true }
    use { "williamboman/mason-lspconfig.nvim", opt = true }
    use { "jay-babu/mason-null-ls.nvim", opt = true }
    use { "ray-x/lsp_signature.nvim", opt = true }
    use { "j-hui/fidget.nvim", opt = true }

    -- Additional LSP Tools
    use { "ThePrimeagen/refactoring.nvim" }
    use { "b0o/SchemaStore.nvim", opt = true }
    use { "simrat39/rust-tools.nvim", ft = "rust" }

    -- Snippets
    use { "L3MON4D3/LuaSnip", opt = true }
    use { "rafamadriz/friendly-snippets" }

    -- Pairs
    use { "windwp/nvim-autopairs", opt = true }

    -- Autocompletion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
            { "lukas-reineke/cmp-under-comparator" },
            { "onsails/lspkind.nvim" },
        },
        event = "InsertEnter",
        wants = { "LuaSnip", "nvim-autopairs" },
        config = function()
            require "config.cmp"
        end,
    }

    -- Commenting
    use {
        "numToStr/Comment.nvim",
        requires = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                module = "ts_context_commentstring",
            },
        },
        keys = {
            { "n", "gcc" },
            { "n", "gbc" },
            { "v", "gc" },
            { "v", "gb" },
        },
        config = function()
            require("Comment").setup {
                ignore = "^$", -- ignore empty lines
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
    }

    -- Colorizer
    use {
        "NvChad/nvim-colorizer.lua",
        ft = { "css", "javascript", "vim", "html", "latex", "tex" },
        config = [[require("colorizer").setup()]],
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        config = "require('config.telescope')",
    }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        run = ":TSUpdate",
        config = function()
            require "config.treesitter"
        end,
    }

    -- Profiler
    use {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    }
end

return M
