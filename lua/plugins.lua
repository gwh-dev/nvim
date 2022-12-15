local M = {}

function M.plugins(use)
  use "stevearc/dressing.nvim"

  -- Colorscheme
  use {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").load()
    end,
  }

  -- Utils
  use {
    "ojroques/nvim-bufdel",
    cmd = "BufDel",
    config = function()
      require("bufdel").setup()
    end,
  }

  -- LSP Support
  use { "neovim/nvim-lspconfig" }
  use { "jose-elias-alvarez/null-ls.nvim" }
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "jay-babu/mason-null-ls.nvim" }
  use { "ray-x/lsp_signature.nvim" }

  -- Additional Servers
  use { "b0o/SchemaStore.nvim" }
  use { "simrat39/rust-tools.nvim", ft = "rust" }

  -- Snippets
  use { "L3MON4D3/LuaSnip", opt = true }
  use { "rafamadriz/friendly-snippets" }

  -- Autocompletion

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      -- { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-lspconfig" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "lukas-reineke/cmp-under-comparator" },
      { "onsails/lspkind.nvim" },
    },
    event = "InsertEnter",
    wants = "LuaSnip",
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

  use { "nvim-telescope/telescope-fzy-native.nvim", opt = true }
  -- Search
  use {
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/popup.nvim",
    wants = {
      "popup.nvim",
      "telescope-fzy-native.nvim",
    },
    cmd = "Telescope",
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

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require "config.autopairs"
    end,
  }

  -- Profiler
  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  }
end

return M
