local cmd = vim.cmd
cmd "packadd nvim-treesitter-refactor"
cmd "packadd nvim-treesitter-textsubjects"

require("nvim-treesitter.configs").setup {
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = false },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<cr>",
			node_incremental = "<tab>",
			scope_incremental = "<cr>",
			scope_decremental = "<s-cr>",
			node_decremental = "<s-tab>",
		},
	},
	autopairs = { enable = true },
	refactor = {
		smart_rename = { enable = true, keymaps = { smart_rename = "grr" } },
		highlight_definitions = { enable = true },
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	textsubjects = {
		enable = true,
		lookahead = true,
		keymaps = {
			["."] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer",
			["i;"] = "textsubjects-container-inner",
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
			["al"] = "@loop.outer",
			["il"] = "@loop.inner",
			["ib"] = "@block.inner",
			["ab"] = "@block.outer",
			["ir"] = "@parameter.inner",
			["ar"] = "@parameter.outer",
		},
	},
}
