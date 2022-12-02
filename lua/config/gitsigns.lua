require("gitsigns").setup {
	signs = {
		add = { hl = "GitSignsAddNr" },
		change = { hl = "GitSignsChangeNr" },
		delete = { hl = "GitSignsDeleteNr" },
		topdelete = { hl = "GitSignsDeleteNr" },
		changedelete = { hl = "GitSignsChangeNr" },
	},
	-- sign_priority = 100,
	keymaps = {},
	numhl = false,
}
