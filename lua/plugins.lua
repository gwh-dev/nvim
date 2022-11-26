local function init()
	if packer == nil then
		packer = require "packer"
		packer.init {
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
		}
	end

	local use = packer.use
	packer.reset()

	-- Essentials
	use "nvim-lua/popup.nvim"
	use "wbthomason/packer.nvim"
	use "nvim-lua/plenary.nvim"
	use "kyazdani42/nvim-web-devicons"

	-- Plugin development
	use "folke/neodev.nvim"

	-- Performance
	use "lewis6991/impatient.nvim"
	use "nathom/filetype.nvim"

	use { -- Colorscheme
		"catppuccin/nvim",
		as = "catppuccin",
		config = [[require('config.colorscheme')]],
	}

	-- Editer & Motions
	use "windwp/nvim-autopairs"

	use {
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
	}

	use {
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
		keys = "s",
	}

	use {
		"ojroques/nvim-bufdel",
		cmd = "BufDel",
		config = function()
			require("bufdel").setup {}
		end,
	}

	use {
		"filipdutescu/renamer.nvim",
		branch = "master",
		requires = { { "nvim-lua/plenary.nvim" } },
		module = "renamer",
	}

	use {
		"lukas-reineke/indent-blankline.nvim",
		after = "catppuccin",
	}

	-- Highlight colors
	use {
		"NvChad/nvim-colorizer.lua",
		ft = { "css", "javascript", "vim", "html", "latex", "tex", "conf", "yml" },
		config = [[require('colorizer').setup {}]],
	}

	-- profiler
	use { "dstein64/vim-startuptime", cmd = "StartupTime", config = [[vim.g.startuptime_tries = 20]] }

	-- Commenting
	use {
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
		module = "Comment",
		keys = { "gc", "gb", "gcc" },
	}

	-- Undo tree
	use {
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
	}

	-- Search
	use {
		{
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				"telescope-fzf-native.nvim",
				"nvim-telescope/telescope-ui-select.nvim",
			},
			wants = {
				"popup.nvim",
				"plenary.nvim",
				"telescope-fzf-native.nvim",
			},
			config = [[require('config.telescope')]],
			cmd = "Telescope",
			module = "telescope",
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
		},
	}

	use { --treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			requires = {
				"nvim-treesitter/nvim-treesitter-refactor",
				{"p00f/nvim-ts-rainbow", after = "nvim-treesitter"},
				{ "nvim-treesitter/nvim-treesitter-context", after = "nvim-treesitter" },
				{ "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" },
			},
			wants = {
				"nvim-treesitter-refactor",
				"nvim-treesitter-context",
				"nvim-treesitter-textsubjects",
			},
			config = [[require('config.treesitter')]],
			event = "BufRead",
			after = "catppuccin",
			run = ":TSUpdate",
		},
		{
			"windwp/nvim-ts-autotag",
			ft = { "html", "js" },
		},
	}
	-- Endwise
	use "RRethy/nvim-treesitter-endwise"

	-- Documentation
	use {
		"danymat/neogen",
		requires = "nvim-treesitter",
		config = [[require('config.neogen')]],
		keys = { "<localleader>d", "<localleader>df", "<localleader>dc" },
	}

	-- Git
	use {
		{
			"lewis6991/gitsigns.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = [[require('config.gitsigns')]],
		},
		{ "TimUntersberger/neogit", cmd = "Neogit", config = [[require('config.neogit')]] },
		{
			"akinsho/git-conflict.nvim",
			tag = "*",
			config = function()
				require("git-conflict").setup()
			end,
		},
	}

	-- Completion and linting
	use {
		{
			"neovim/nvim-lspconfig",
			config = [[require('config.lsp')]],
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"neovim/nvim-lspconfig",
			},
		},
		"ray-x/lsp_signature.nvim",
	}

	use {
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		config = function()
			require("trouble").setup {}
		end,
	}

	--snippets
	use {
		{
			"L3MON4D3/LuaSnip",
			opt = true,
		},
		"rafamadriz/friendly-snippets",
	}

	use {
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind.nvim",
			"lukas-reineke/cmp-under-comparator",
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
		},
		config = [[require('config.cmp')]],
		event = "InsertEnter",
		wants = "LuaSnip",
	}

	-- Make UI Better
	use {
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup {}
		end,
	}

	use {
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup {
				window = {
					blend = 0,
				},
				sources = {
					["null-ls"] = { ignore = true },
				},
			}
		end,
	}
end -- Don't pass this " end " you will get an ERROR

local plugins = setmetatable({}, {
	__index = function(_, key)
		init()
		return packer[key]
	end,
})

return plugins
