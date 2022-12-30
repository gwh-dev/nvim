vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

require "core.lazy"
require("core.settings")

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("core.autocommands")
        require("core.mappings")
    end,
})
