local function init()
	if packer == nil then
		packer = require "packer"
		packer.init {
			-- disable_commands = true,
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
	use "kyazdani42/nvim-web-devicons"

	-- [[ Performance ]]
	use "lewis6991/impatient.nvim"
	use "nathom/filetype.nvim"

	-- [[ Colorscheme ]]
	use {
		"catppuccin/nvim",
		as = "catppuccin",
		setup = function()
			vim.cmd.colorscheme "catppuccin-frappe"
		end,
		config = function()
			require("catppuccin").setup {
				transparent_background = true,
				integrations = {
					cmp = true,
					gitsigns = true, -- For Now
					neogit = true,
					nvimtree = false,
					-- fidget = false,
					telescope = true,
					lsp_trouble = true,
					native_lsp = { enabled = true },
					indent_blankline = { enabled = true },
					treesitter = true,
					-- treesitter_context = true,
					-- leap = false,
					-- lightspeed = false,
					-- notify = false,
					-- dap = true,
					-- lualine = false,
					-- ts_rainbow = false,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			}
		end,
	}

	-- [[ Motions ]]

	use {
		"monkoose/matchparen.nvim",
		event = { "BufWinEnter", "BufNewFile" },
		config = function()
			require("matchparen").setup()
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

	-- use {
	-- 	"ggandor/leap.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("leap").add_default_mappings()
	-- 	end,
	-- }

	-- [[ Utils ]]

	use {
		"jghauser/mkdir.nvim",
		event = "BufWritePre",
	}

	-- use {
	-- 	"filipdutescu/renamer.nvim",
	-- 	branch = "master",
	-- 	requires = { { "nvim-lua/plenary.nvim" } },
	-- 	module = "renamer",
	-- }

	use {
		"ojroques/nvim-bufdel",
		cmd = "BufDel",
		config = function()
			require("bufdel").setup {}
		end,
	}

	-- Bracets
	use {
		{
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("nvim-surround").setup()
			end,
		},
		"windwp/nvim-autopairs",
	}

	-- [[ Highlight colors ]]
	use {
		"NvChad/nvim-colorizer.lua",
		ft = { "css", "javascript", "vim", "html", "latex", "tex", "conf", "yml" },
		config = [[require('colorizer').setup {}]],
	}

	-- [[ Profiler ]]
	use { "dstein64/vim-startuptime", cmd = "StartupTime", config = [[vim.g.startuptime_tries = 20]] }

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
		"nvim-treesitter/nvim-treesitter",
		requires = {
			{
				"nvim-treesitter/nvim-treesitter-refactor",
				after = "nvim-treesitter",
			},
			{
				"RRethy/nvim-treesitter-textsubjects",
				after = "nvim-treesitter",
			},
		},
		event = { "BufRead", "BufNewFile" },
		run = ":TSUpdate",
	}

	-- [[ Commenting ]]
	use {
		"numToStr/Comment.nvim",
		requires = {
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				module = "ts_context_commentstring",
				keys = "gcc",
			},
		},
		config = function()
			require("config.comment").config()
		end,
		keys = { "gc", "gb" },
		-- event = { 'BufWinEnter', 'BufNewFile' },
		after = "nvim-treesitter",
	}

	-- [[ indent line ]]
	use "lukas-reineke/indent-blankline.nvim"

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
			config = [[require('config.lsp')]],
			requires = {
				"b0o/SchemaStore.nvim",
			},
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"neovim/nvim-lspconfig",
			},
		},
		-- "ray-x/lsp_signature.nvim",
	}

	use {
		"folke/trouble.nvim",
		cmd = "Trouble",
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
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
		},
		config = [[require('config.cmp')]],
		event = "InsertEnter",
		wants = "LuaSnip",
	}

	-- [[ Make UI Better ]]
	use {
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup {}
		end,
	}

	-- use {
	-- 	"j-hui/fidget.nvim",
	-- 	config = function()
	-- 		require("fidget").setup {
	-- 			text = {
	-- 				spinner = "dots",
	-- 			},
	-- 			window = {
	-- 				blend = 0,
	-- 			},
	-- 			sources = {
	-- 				["null-ls"] = { ignore = true },
	-- 			},
	-- 		}
	-- 	end,
	-- }
end -- Don't pass this "end" you will get an ERROR

local plugins = setmetatable({}, {
	__index = function(_, key)
		init()
		return packer[key]
	end,
})

return plugins
