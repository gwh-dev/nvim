require("lspsaga").init_lsp_saga {
    border_style = "rounded",
    rename_action_quit = "<ESC><ESC>",
    symbol_in_winbar = {
        in_custom = true,
        separator = " 》",
    },
    code_action_lightbulb = {
        enable_in_insert = false,
        virtual_text = false,
    },
    code_action_icon = "",
}
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "CursorMoved", "WinLeave", "User LspsagaUpdateSymbol" }, {
    group = vim.api.nvim_create_augroup("winbar", { clear = true }),
    pattern = "*",
    once = true,
    callback = function()
        if vim.fn.winheight(0) > 1 then
            vim.o.winbar = "%!v:lua.require('winbar').bar()"
        end
    end,
})
