require "core.settings"
require "core.lazy"

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require "core.autocommands"
        require "core.mappings"
        if package.loaded["gruvbox-baby"] then
            if package.loaded["nvim-treesitter"] then
                vim.cmd "syntax on"
            end
        end
    end,
    once = true,
})
