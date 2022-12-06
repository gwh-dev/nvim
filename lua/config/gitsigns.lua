
require("gitsigns").setup({
  signs = {
    add = { text = "▎", hl = "GitSignsAddNr" },
    change = { text = "▎", hl = "GitSignsChangeNr" },
    delete = { text = "▎", hl = "GitSignsDeleteNr" },
    topdelete = { text = "▎", hl = "GitSignsDeleteNr" },
    changedelete = { text = "▎", hl = "GitSignsChangeNr" },
  },
})
