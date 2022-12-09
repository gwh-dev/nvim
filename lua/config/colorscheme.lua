local catppuccin = require "catppuccin"
catppuccin.load "frappe"
catppuccin.setup {
  transparent_background = false,
  integrations = {
    cmp = true,
    telescope = true,
    native_lsp = { enabled = true },
    treesitter = true,
    -- lspsaga = true,
  },
}
