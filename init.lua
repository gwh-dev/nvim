vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

require("core.settings")
require("core.lazy")

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("core.autocommands")
        require("core.mappings")
    end,
})
