local fn = vim.fn
local cmd = vim.cmd
local BOOTSTRAP = false
local INSTALL_PATH = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local COMPILE_PATH = fn.stdpath "config" .. "/lua/compiled.lua"

if fn.empty(fn.glob(INSTALL_PATH)) > 0 then
    print "Clonning packer"
    fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", INSTALL_PATH }
    cmd [[packadd packer.nvim]]
    BOOTSTRAP = true
end

local packer = nil
local function init()
    vim.cmd "packadd packer.nvim"
    if packer == nil then
        local util = require "packer.util"
        packer = require "packer"
        packer.init {
            profile = { enable = true },
            disable_commands = true,
            display = {
                open_fn = function()
                    local result, win, buf = util.float {
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
            compile_path = util.join_paths(COMPILE_PATH),
            auto_clean = true,
            compile_on_sync = true,
            auto_reload_compiled = true,
        }
    end

    local use = packer.use
    packer.reset()

    -- Essentials
    use { "wbthomason/packer.nvim" }
    use { "nvim-lua/plenary.nvim" }
    use { "nvim-lua/popup.nvim" }
    -- Performance
    use { "lewis6991/impatient.nvim" }
    -- Colorscheme
    use { "folke/tokyonight.nvim" }

    use { "windwp/nvim-autopairs" }
    -- use { "kylechui/nvim-surround", tag = "*", config = [[require("nvim-surround").setup()]] }

    use {
        {
            "neovim/nvim-lspconfig",
            module = "lspconfig",
            config = function()
                require "config.lsp"
            end,
            setup = function()
                vim.defer_fn(function()
                    require("plugins").loader "nvim-lspconfig"
                end, 0)
            end,
        },
        { "jose-elias-alvarez/null-ls.nvim", module = "null-ls", after = "nvim-lspconfig" },
        -- { "glepnir/lspsaga.nvim", branch = "main" },
    }
    -- snippets
    use { "L3MON4D3/LuaSnip", opt = true }
    use { "rafamadriz/friendly-snippets", after = "LuaSnip" }
    -- cmp
    use {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        module = "cmp",
        wants = "LuaSnip",
        config = [[require('config.cmp')]],
    }
    use { "onsails/lspkind.nvim" }
    -- use { "lukas-reineke/cmp-under-comparator" }
    use { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }

    -- Pretty <3
    use {
        "NvChad/nvim-colorizer.lua",
        config = [[require('colorizer').setup()]],
        --setup = [[lazy "nvim-colorizer.lua"]],
    }
    -- [[ Search ]]
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use {
        "nvim-telescope/telescope.nvim",
        wants = "telescope-fzf-native.nvim",
        cmd = "Telescope",
        module = "telescope",
        config = [[require('config.telescope')]],
    }
    use { "mbbill/undotree", cmd = "UndotreeToggle", config = [[vim.g.undotree_SetFocusWhenToggle = 1]] }
    -- [[ Treesitter ]]
    use {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        run = ":TSUpdate",
        config = [[require("config.treesitter")]],
    }
    use {
        "RRethy/vim-illuminate",
        after = "nvim-treesitter",
        config = function()
            require("illuminate").configure {
                -- set highest priority for treesitter, and disable regex search
                providers = { "treesitter", "lsp" },
            }
        end,
    }
    -- use { "nvim-treesitter/nvim-treesitter-refactor" }
    -- [[ Commenting ]]
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

-- install_packer will use git to install packer to the install_path

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end,
})
function plugins.command()
    local create_cmd = vim.api.nvim_create_user_command
    create_cmd("PackerInstall", function()
        cmd [[packadd packer.nvim]]
        require("plugins").install()
    end, {})
    create_cmd("PackerUpdate", function()
        cmd [[packadd packer.nvim]]
        require("plugins").update()
    end, {})
    create_cmd("PackerSync", function()
        cmd [[packadd packer.nvim]]
        require("plugins").sync()
    end, {})
    create_cmd("PackerClean", function()
        cmd [[packadd packer.nvim]]
        require("plugins").clean()
    end, {})
    create_cmd("PackerCompile", function()
        cmd [[packadd packer.nvim]]
        require("plugins").compile()
    end, {})
    create_cmd("PackerStatus", function()
        cmd [[packadd packer.nvim]]
        require("plugins").status()
    end, {})
end

if BOOTSTRAP == true then
    plugins.clean()
    plugins.compile()
    plugins.sync()
    print(string.format("packer.nvim installed in: %s and compiled in: %s", INSTALL_PATH, COMPILE_PATH))
end

if vim.fn.filereadable(COMPILE_PATH) == 1 then
    require "compiled"
    plugins.command()
else
    print "I can't find compiled.lua trying again"
    cmd "packadd packer.nvim"
    plugins.compile()
    require "compiled"
    plugins.command()
end

return plugins
