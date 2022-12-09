local catppuccin = require("catppuccin")
catppuccin.load("frappe")
catppuccin.setup({
  transparent_background = false,
  integrations = {
    cmp = true,
    gitsigns = true, -- For Now
    neogit = true,
    telescope = true,
    native_lsp = { enabled = true },
    treesitter = true,
  },
})
