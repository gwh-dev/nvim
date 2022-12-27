local M = {}

function M.plugins(use)
    -- Motions
    use {
        {
            "ggandor/leap.nvim",
            keys = { "s", "S", "f", "F", "t", "T" },
            config = [[require("leap").add_default_mappings()]],
            requires = "tpope/vim-repeat",
        },
        {
            "ggandor/flit.nvim",
            after = "leap.nvim",
            config = [[require('flit').setup { labeled_modes = 'nv' }]],
        },
    }

    -- File Browser
    use {
        "nvim-neo-tree/neo-tree.nvim",
        config = [[vim.g.neo_tree_remove_legacy_commands = true]],
        requires = {
            { "MunifTanjim/nui.nvim", cmd = "Neotree" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-tree/nvim-web-devicons" },
        },
        after = "nui.nvim",
        branch = "v2.x",
    }

    -- LSP Support
    use {
        "neovim/nvim-lspconfig",
        requires = {
            { "jose-elias-alvarez/null-ls.nvim", opt = true },
            { "williamboman/mason.nvim", opt = true },
            { "williamboman/mason-lspconfig.nvim", opt = true },
            { "jay-babu/mason-null-ls.nvim", opt = true },
            { "j-hui/fidget.nvim", opt = true },
        },
        event = "BufReadPost",
        config = [[require("config.lsp")]],
    }

    -- LSP Additionals
    use { "SmiteshP/nvim-navic" }
    -- use { "ThePrimeagen/refactoring.nvim" }
    -- use { "b0o/SchemaStore.nvim", ft = "json" }
    -- use { "simrat39/rust-tools.nvim", ft = "rust" }

    -- -- Snippets
    use { "L3MON4D3/LuaSnip", opt = true }
    use { "rafamadriz/friendly-snippets", after = "LuaSnip" } -- No need for lazyloading

    -- Autocompletion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
            --
            { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
            { "saadparwaiz1/cmp_luasnip", after = "cmp-nvim-lsp-signature-help" },
            { "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" },
            { "hrsh7th/cmp-path", after = "cmp-nvim-lua" },
            { "hrsh7th/cmp-buffer", after = "cmp-path" },
            { "lukas-reineke/cmp-under-comparator", opt = true },
            { "onsails/lspkind.nvim", opt = true },
        },
        event = "InsertEnter",
        wants = "LuaSnip",
        config = [[require "config.cmp"]],
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

    use { "nvim-telescope/telescope-fzy-native.nvim", opt = true }
    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
        wants = "telescope-fzy-native.nvim",
        cmd = "Telescope",
        config = [[require("config.telescope")]],
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        run = ":TSUpdate",
        config = [[require("config.treesitter")]],
    }

    -- Utils
    use {
        "ojroques/nvim-bufdel",
        cmd = "BufDel",
        config = [[require("bufdel").setup()]],
    }

    use {
        "monkoose/matchparen.nvim",
        after = "nvim-treesitter",
        config = [[require("matchparen").setup()]],
    }

    use {
        "kylechui/nvim-surround",
        tag = "*",
        config = [[require("nvim-surround").setup()]],
        after = "nvim-treesitter",
    }
    use { "windwp/nvim-autopairs", opt = true }

    use {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
    }

    -- Colorscheme
    use {
        "marko-cerovac/material.nvim",
        -- "olimorris/onedarkpro.nvim",
        config = [[require("config.colorscheme")]],
        after = "nvim-treesitter",
    }

    -- Profiler
    use {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    }
end

return M
