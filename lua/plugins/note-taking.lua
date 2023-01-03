local M = {
    {
        "nvim-neorg/neorg",
        ft = "norg",
        priority = 2000,
        dependencies = {
            { "jbyuki/nabla.nvim", keys = { { "<leader>p", "<cmd>:lua require('nabla').popup()<cr>" } } },
            -- { "Pocco81/HighStr.nvim", config = true },
            {
                "jbyuki/venn.nvim",
                config = function()
                    -- venn.nvim: enable or disable keymappings
                    local function Toggle_venn()
                        local venn_enabled = vim.inspect(vim.b.venn_enabled)
                        if venn_enabled == "nil" then
                            vim.b.venn_enabled = true
                            vim.cmd [[setlocal ve=all]]
                            vim.opt.cursorline = true
                            vim.opt.cursorcolumn = true
                            -- draw a line on HJKL keystokes
                            vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
                            vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
                            vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
                            vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
                            -- draw a box by pressing "f" with visual selection
                            vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
                        else
                            vim.opt.cursorline = false
                            vim.opt.cursorcolumn = false
                            vim.cmd [[setlocal ve=]]
                            vim.cmd [[mapclear <buffer>]]
                            vim.b.venn_enabled = nil
                        end
                    end
                    -- toggle keymappings for venn using <leader>v
                    vim.keymap.set("n", "<leader>v", function()
                        Toggle_venn()
                    end)
                end,
            },
            {
                "dhruvasagar/vim-table-mode",
                config = function()
                    vim.g.table_mode_corner_corner = "+"
                    vim.cmd [[
                    function! s:isAtStartOfLine(mapping)
                        let text_before_cursor = getline('.')[0 : col('.')-1]
                        let mapping_pattern = '\V' . escape(a:mapping, '\')
                        let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
                        return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
                    endfunction

                    inoreabbrev <expr> <bar><bar>
                        \ <SID>isAtStartOfLine('\|\|') ?
                        \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
                    inoreabbrev <expr> __
                        \ <SID>isAtStartOfLine('__') ?
                         \ '<c-o>:silent! TableModeDisable<cr>' : '__'
                    ]]
                end,
            },
        },
        config = {
            load = {
                ["core.defaults"] = {},
                ["core.norg.concealer"] = {},
                ["core.norg.completion"] = {
                    config = { engine = "nvim-cmp" },
                },
                ["core.integrations.nvim-cmp"] = {},
            },
        },
    },
    {
        "phaazon/mind.nvim",
        -- branch = "v2.2",
        keys = {
            { "<leader>am", "<cmd>MindOpenMain<cr>", desc = "Main Note Taking Tree" },
            { "<leader>ap", "<cmd>MindOpenSmartProject<cr>", desc = "Project Note Taking Tree" },
        },
        config = {
            ui = {
                width = 5,
            },
            edit = {
                data_header = "@document.meta\ntitle: %s\n@end",
                data_extension = ".norg",
                copy_link_format = "[]{%s}",
            },
        },
    },
}

return M
