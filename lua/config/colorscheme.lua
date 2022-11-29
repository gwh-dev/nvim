local cmd = vim.cmd.colorscheme

require("catppuccin").setup {
	flavour = "frappe", -- latte, frappe, macchiato, mocha
	transparent_background = true,
	no_italic = true, -- Force no italic
	no_bold = true, -- Force no bold
	integrations = {
		cmp = true,
		gitsigns = true, -- For Now
    neogit = true,
		nvimtree = false,
		fidget = true,
		telescope = true,
		lsp_trouble = true,
		native_lsp = { enabled = true },
		indent_blankline = { enabled = true },
		treesitter = true,
		treesitter_context = true,
		leap = true,
    lightspeed = false,
    notify = true,
		dap = true,
		lualine = false,
    ts_rainbow = true,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
}

cmd "catppuccin"
