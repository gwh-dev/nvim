local M = {
    "akinsho/nvim-bufferline.lua",
    event = "BufAdd",
}

function M.config()
    local severitys = { error = " ", warning = " ", hint = " ", info = " " }
    require("bufferline").setup {
        options = {
            show_close_icon = false,
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            separator_style = "thick",
            diagnostics_indicator = function(_, _, diag)
                local s = {}
                for severity, icon in ipairs(severitys) do
                    if diag[severity] then
                        table.insert(s, icon[severity] .. diag[severity])
                    end
                end
                return table.concat(s, " ")
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo Tree",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
        },
    }
end

function M.init()
    vim.keymap.set("n", "<S-h>", "<cmd>:BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
    vim.keymap.set("n", "<S-l>", "<cmd>:BufferLineCycleNext<CR>", { desc = "Next Buffer" })
end

return M
