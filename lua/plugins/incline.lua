local M = {
    "b0o/incline.nvim",
    event = "BufReadPre",
}

function M.config()
    local colors = require("onedarkpro.helpers").get_colors()

    require("incline").setup {
        highlight = {
            groups = {
                InclineNormal = {
                    guifg = colors.orange,
                    guibg = colors.bg,
                    -- gui = "bold",
                },
                InclineNormalNC = {
                    guifg = colors.fg,
                    guibg = colors.bg,
                },
            },
        },
        window = {
            margin = {
                vertical = 0,
                horizontal = 1,
            },
        },
        render = function(props)
            local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
            local icon, color = require("nvim-web-devicons").get_icon_color(filename)
            return {
                { icon, guifg = color },
                { " " },
                { filename },
            }
        end,
    }
end

return M
