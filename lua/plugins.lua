local fn = vim.fn
local cmd = vim.cmd
local BOOTSTRAP = false
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    print "Clonning packer"
    fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    cmd "packadd packer.nvim"
    BOOTSTRAP = true
end

local packer = nil
local function load()
    if packer == nil then
        cmd "packadd packer.nvim"
        packer = require "packer"
        packer.init {
            profile = { enable = true },
            disable_commands = true,
            display = {
                open_fn = function()
                    local result, win, buf = require("packer.util").float {
                        border = {
                            { "╭", "FloatBorder" },
                            { "─", "FloatBorder" },
                            { "╮", "FloatBorder" },
                            { "│", "FloatBorder" },
                            { "╯", "FloatBorder" },
                            { "─", "FloatBorder" },
                            { "╰", "FloatBorder" },
                            { "│", "FloatBorder" },
                        },
                    }
                    vim.api.nvim_win_set_option(win, "winhighlight", "NormalFloat:Normal")
                    return result, win, buf
                end,
            },
            git = {
                clone_timeout = 800, -- In Seconds
            },
            auto_clean = true,
            compile_on_sync = true,
            auto_reload_compiled = true,
        }
    end

    packer.reset()
    local use = packer.use
    use { "wbthomason/packer.nvim" }
    use { "nvim-lua/plenary.nvim" }
    use { "nvim-lua/popup.nvim" }
    use { "lewis6991/impatient.nvim" }
    use { "windwp/nvim-autopairs" }
    -- use "EdenEast/nightfox.nvim"
    use { "folke/tokyonight.nvim" }
    -- use { "ellisonleao/gruvbox.nvim" }
    -- use { "Everblush/everblush.nvim", as = "everblush" }
    -- use { "nyoom-engineering/oxocarbon.nvim", as = "oxocarbon" }

    use "ojroques/nvim-bufdel"
    use {
        "neovim/nvim-lspconfig",
        opt = true,
        config = function()
            require "config.lsp"
            vim.defer_fn(function()
                vim.cmd "silent! e %"
            end, 0)
        end,
        setup = function()
            lazy "nvim-lspconfig"
        end,
    }
    use { "jose-elias-alvarez/null-ls.nvim", module = "null-ls", after = "nvim-lspconfig" }
    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
        after = "nvim-lspconfig",
        config = function()
            require "config.saga"
        end,
    }
    use {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = function()
            require("rust-tools").setup {}
        end,
    }
    use { "L3MON4D3/LuaSnip", opt = true }
    use { "rafamadriz/friendly-snippets", after = "LuaSnip" }
    use {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        module = "cmp",
        wants = "LuaSnip",
        config = [[require('config.cmp')]],
    }
    use "onsails/lspkind.nvim"
    use "lukas-reineke/cmp-under-comparator"
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
    use { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use {
        "NvChad/nvim-colorizer.lua",
        opt = true,
        config = [[require('colorizer').setup()]],
        setup = function()
            lazy "nvim-colorizer.lua"
        end,
    }
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        cmd = "Telescope",
    }

    use {
        "nvim-telescope/telescope.nvim",
        after = "telescope-fzf-native.nvim",
        config = function()
            require "config.telescope"
        end,
    }
    use { "mbbill/undotree", cmd = "UndotreeToggle", config = [[vim.g.undotree_SetFocusWhenToggle = 1]] }
    use {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        run = ":TSUpdate",
        config = function()
            require "config.treesitter"
        end,
    }
    use {
        "RRethy/vim-illuminate",
        after = "nvim-treesitter",
        config = function()
            require("illuminate").configure {
                providers = { "treesitter", "lsp" },
            }
        end,
    }
    use {
        "numToStr/Comment.nvim",
        keys = {
            { "n", "gcc" },
            { "n", "gbc" },
            { "v", "gc" },
            { "v", "gb" },
        },
        config = [[require("config.comment")]],
    }
    use { "JoosepAlviste/nvim-ts-context-commentstring", module = "ts_context_commentstring" }
    use {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup {
                text = {
                    spinner = "dots", -- animation shown when tasks are ongoing
                },
                window = {
                    blend = 0,
                },
                sources = {
                    ["null-ls"] = { ignore = true },
                },
            }
        end,
    }
    -- [[ Profile ]]
    use { "dstein64/vim-startuptime", cmd = "StartupTime", config = [[vim.g.startuptime_tries = 20]] }
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        load()
        return packer[key]
    end,
})

if BOOTSTRAP then
    plugins.sync()
end

local create_cmd = vim.api.nvim_create_user_command
create_cmd("Install", function()
    cmd [[packadd packer.nvim]]
    plugins.install()
end, {})
create_cmd("Update", function()
    cmd [[packadd packer.nvim]]
    plugins.update()
end, {})
create_cmd("Sync", function()
    cmd [[packadd packer.nvim]]
    plugins.sync()
end, {})
create_cmd("Clean", function()
    cmd [[packadd packer.nvim]]
    plugins.clean()
end, {})
create_cmd("Compile", function()
    cmd [[packadd packer.nvim]]
    plugins.compile()
end, {})
create_cmd("Status", function()
    cmd [[packadd packer.nvim]]
    plugins.status()
end, {})

return plugins
