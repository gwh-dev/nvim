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
				prompt_border = "rounded",
			},
			git = {
				clone_timeout = 800, -- In Seconds
			},
		}
	end

	local use = packer.use
	packer.reset()

	-- [[ Essentials ]]
	use "nvim-lua/popup.nvim"
	use "wbthomason/packer.nvim"
	use "nvim-lua/plenary.nvim"
	-- use "kyazdani42/nvim-web-devicons"

	-- [[ Performance ]]
	use "lewis6991/impatient.nvim"
	use "nathom/filetype.nvim"

	-- [[ Colorscheme ]]
	use {
		"catppuccin/nvim",
		as = "catppuccin",
		setup = function()
			vim.cmd.colorscheme "catppuccin"
		end,
		config = function()
			require("catppuccin").setup {
				transparent_background = true,
				integrations = {
					cmp = true,
					gitsigns = true, -- For Now
					neogit = true,
					telescope = true,
					native_lsp = { enabled = true },
					treesitter = true,
				},
			}
		end,
	}

	-- [[ Utils ]]
	--
	use {
		"monkoose/matchparen.nvim",
		event = { "BufWinEnter", "BufNewFile" },
		config = function()
			require("matchparen").setup()
		end,
	}

	use {
		"jghauser/mkdir.nvim",
		event = "BufWritePre",
	}

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
				-- "nvim-telescope/telescope-ui-select.nvim",
			},
			wants = {
				"popup.nvim",
				"plenary.nvim",
				"telescope-fzf-native.nvim",
				-- "telescope-ui-select.nvim",
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
			{ "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" },
			{ "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" },
		},
		setup = function()
			require "config.treesitter"
		end,
		config = function()
			require "config.treesitter"
		end,
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
			require("Comment").setup {
				ignore = "^$", -- ignore empty lines
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
		end,
		-- keys = { "gc", "gb" },
		-- event = { 'BufWinEnter', 'BufNewFile' },
		after = "nvim-treesitter",
	}

	-- [[ Documentation ]]
	-- use {
	-- 	"danymat/neogen",
	-- 	requires = "nvim-treesitter",
	-- 	config = function()
	-- 		require("neogen").setup { enabled = true, jump_map = "<tab>" }
	-- 	end,
	-- 	keys = { "<localleader>d", "<localleader>df", "<localleader>dc" },
	-- }

	-- [[ Git ]]

	use {
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
	}

	use {
		{
			"lewis6991/gitsigns.nvim",
			-- requires = "nvim-lua/plenary.nvim",
			config = function()
				require("gitsigns").setup()
			end,
		},
		{
			"TimUntersberger/neogit",
			cmd = "Neogit",
			config = function()
				require("neogit").setup {
					disable_commit_confirmation = true,
					disable_signs = true,
					disable_builtin_notifications = true,
				}
			end,
		},
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
			-- requires = {
			-- 	"b0o/SchemaStore.nvim",
			-- },
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"neovim/nvim-lspconfig",
			},
		},
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
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "onsails/lspkind.nvim" },
			{ "lukas-reineke/cmp-under-comparator" },
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
		},
		config = [[require('config.cmp')]],
		event = "InsertEnter",
		wants = "LuaSnip",
	}

	-- Debugger
	use {
		{
			"mfussenegger/nvim-dap",
			config = [[require('config.dap')]],
			requires = {
				"leoluz/nvim-dap-go",
			},
			wants = {
				"nvim-dap-go",
			},
			cmd = { "DapToggleBreakpoint", "Debug", "DapToggleRepl" },
		},
		{
			"rcarriga/nvim-dap-ui",
			requires = "nvim-dap",
			wants = "nvim-dap",
			after = "nvim-dap",
		},
		{
			"theHamsta/nvim-dap-virtual-text",
		},
	}
end -- Don't pass this "end" you will get an ERROR

local plugins = setmetatable({}, {
	__index = function(_, key)
		init()
		return packer[key]
	end,
})

return plugins
