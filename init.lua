require "core.settings"
require "core.lazy"

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require "core.autocommands"
        require "core.mappings"
        if vim.bo.filetype == "" then
            vim.cmd "Alpha"
        end
    end,
    once = true,
})
