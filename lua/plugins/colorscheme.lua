return {
	"olimorris/onedarkpro.nvim",
	event = "VeryLazy",
	config = function()
		local onedarkpro = require("onedarkpro")
		onedarkpro.setup({
			dark_theme = "onedark",
			highlights = {
				PmenuSel = { bg = "#5c6370" },
			},
			plugins = {
				leap = true,
				neo_tree = true,
				nvim_cmp = true,
				native_lsp = true,
				nvim_navic = true,
				telescope = true,
				treesitter = true,
				-- disable
				nvim_dap_ui = false,
				nvim_dap = false,
				packer = false,
				op_nvim = false,
				trouble = false,
				vim_ultest = false,
				which_key = false,
				toggleterm = false,
				polygot = false,
				nvim_ts_rainbow = false,
				startify = false,
				nvim_tree = false,
				nvim_notify = false,
				nvim_hlslens = false,
				nvim_bqf = false,
				neotest = false,
				marks = false,
				lsp_saga = false,
				aerial = false,
				barbar = false,
				copilot = false,
				dashboard = false,
				gitsigns = false,
				glance = false,
				hop = false,
				indentline = false,
			},
			options = {
				bold = false, -- Use bold styles?
				cursorline = true, -- Use cursorline highlighting?
			},
		})
		onedarkpro.load()
	end,
}
