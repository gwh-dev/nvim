local M = {}

-- lua-language-server
function M.plugins(use)
    -- use "nvim-tree/nvim-web-devicons"
    -- Colorschemes
    -- use { "olimorris/onedarkpro.nvim" }
    -- use { "catppuccin/nvim", as = "catppuccin" }
    use { "sainnhe/gruvbox-material" } -- I love this colorscheme but it give 5ms more to startup. That's bad... :(
    -- use "Murtaza-Udaipurwala/gruvqueen"
    -- use "luisiacc/gruvbox-baby"
    -- use "eddyekofo94/gruvbox-flat.nvim"
    -- use { "tssm/nvim-random-colors" } -- Greate plugin random colorscheme changer

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
    use {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end,
    }

    -- Additional Servers
    -- TODO: Make it work with the lazyload and config
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
    use {
        "JoosepAlviste/nvim-ts-context-commentstring",
        module = "ts_context_commentstring",
    }

    -- Colorizer
    use {
        "NvChad/nvim-colorizer.lua",
        ft = { "css", "javascript", "vim", "html", "latex", "tex" },
        config = [[require("colorizer").setup()]],
    }

    use {
        "nvim-telescope/telescope-fzy-native.nvim",
        opt = true,
        cmd = "Telescope",
        run = function()
            local job_output = require("core.utils").job_output
            if vim.fn.executable "make" == 0 then
                return
            end

            vim.fn.jobstart({ "make" }, {
                cwd = vim.fn.getcwd() .. "/deps/fzy-lua-native",
                on_stdout = job_output,
            })
        end,
    }
    -- Search
    use {
        "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/popup.nvim",
        after = "telescope-fzy-native.nvim",
        config = function()
            require "config.telescope"
        end,
    }

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
