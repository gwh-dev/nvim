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

	-- [[ Essentials ]]
	use "nvim-lua/popup.nvim"
	use "wbthomason/packer.nvim"
	use "nvim-lua/plenary.nvim"
	use "rcarriga/nvim-notify"
	use "kyazdani42/nvim-web-devicons"
	

	-- [[ Plugin development ]]
	use "folke/neodev.nvim"

	-- [[ Performance ]]
	use "lewis6991/impatient.nvim"
	use "nathom/filetype.nvim"

	-- [[ Colorscheme ]]
	use {
		"catppuccin/nvim",
		as = "catppuccin",
		config = [[require('config.colorscheme')]],
	}

	-- [[ Motions ]]
	use {
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	}

	use {
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
	}
  
  use {
		"declancm/cinnamon.nvim",
		config = function()
			require("cinnamon").setup()
		end,
	}

	use {
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
	}

	use {
		"ggandor/leap.nvim",
		event = "VimEnter",
		config = function()
			require("leap").add_default_mappings()
		end,
	}

	-- [[ Utils ]]
	use {
		"lukas-reineke/indent-blankline.nvim",
		after = "catppuccin",
	}

	use {
		"jghauser/mkdir.nvim",
		event = "BufWritePre",
	}

	use {
		"filipdutescu/renamer.nvim",
		branch = "master",
		requires = { { "nvim-lua/plenary.nvim" } },
		module = "renamer",
	}

	use {
		"ojroques/nvim-bufdel",
		cmd = "BufDel",
		config = function()
			require("bufdel").setup {}
		end,
	}
	use "windwp/nvim-autopairs"

	-- [[ Highlight colors ]]
	use {
		"NvChad/nvim-colorizer.lua",
		ft = { "css", "javascript", "vim", "html", "latex", "tex", "conf", "yml" },
		config = [[require('colorizer').setup {}]],
	}

	-- [[ Profiler ]]
	use { "dstein64/vim-startuptime", cmd = "StartupTime", config = [[vim.g.startuptime_tries = 20]] }

	-- [[ Commenting ]]
	use {
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
		module = "Comment",
		keys = { "gc", "gb", "gcc" },
	}

	-- [[ Search ]]
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
				"telescope-ui-select.nvim",
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

	-- [[ Treesitter ]]
	use {
		{
			"nvim-treesitter/nvim-treesitter",
			requires = {
				"nvim-treesitter/nvim-treesitter-refactor",
				"nvim-treesitter/nvim-treesitter-context",
				"RRethy/nvim-treesitter-textsubjects",
				"RRethy/nvim-treesitter-endwise",
				"p00f/nvim-ts-rainbow",
			},
			wants = {
				"nvim-treesitter-refactor",
				"nvim-treesitter-context",
				"nvim-treesitter-textsubjects",
				"nvim-treesitter-endwise",
				"nvim-ts-rainbow",
			},
			event = "BufRead",
			run = ":TSUpdate",
		},
		{
			"windwp/nvim-ts-autotag",
			ft = { "html", "js" },
			after = "nvim-treesitter",
		},
	}

	-- [[ Documentation ]]
	-- use {
	-- 	"danymat/neogen",
	-- 	requires = "nvim-treesitter",
	-- 	config = [[require('config.neogen')]],
	-- 	keys = { "<localleader>d", "<localleader>df", "<localleader>dc" },
	-- }

	-- [[ Git ]]
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

	-- [[ Completion and linting ]]
	use {
		{
			"neovim/nvim-lspconfig",
			-- config = [[require('config.lsp')]],
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

	-- [[ snippets ]]
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

	-- [[ Make UI Better ]]
	-- use "stevearc/dressing.nvim"
	-- use "vigoux/notifier.nvim"
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
end -- Don't pass this "end" you will get an ERROR

local plugins = setmetatable({}, {
	__index = function(_, key)
		init()
		return packer[key]
	end,
})

return plugins
