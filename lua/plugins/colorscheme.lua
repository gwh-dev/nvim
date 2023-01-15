local M = {
    "luisiacc/gruvbox-baby",
    priority = 1000, -- make sure to load this before all the other start plugins
    event = "BufRead",
    branch = "main",
}

function M.config()
    vim.g.gruvbox_baby_function_style = "NONE"
    vim.g.gruvbox_baby_background_color = "soft"
    vim.g.gruvbox_baby_telescope_theme = 1
    vim.g.gruvbox_baby_use_original_palette = true
    vim.g.gruvbox_baby_color_overrides = {
        red = "#f2594b",
        soft_yellow = "#e9b143",
    }
    local colors = require("gruvbox-baby.colors").config()
    vim.g.gruvbox_baby_highlights = {
        SignColumn = { bg = "#3c3a39" },
        ColorColumn = { bg = "#3c3a39" },
        CursorLineNr = { bg = "#3c3a39" },
        GitSignsChange = { bg = "#3c3a39", fg = colors.soft_yellow },
        GitSignsAdd = { bg = "#3c3a39", fg = colors.clean_green },
        GitSignsDelete = { bg = "#3c3a39", fg = colors.red },
        GitSignsChangeDelete = { bg = "#3c3a39", fg = colors.bright_yellow },
        GitSignsUntracked = { bg = "#3c3a39", fg = colors.forest_green },
        DiagnosticSignWarn = { bg = "#3c3a39", fg = colors.bright_yellow },
        DiagnosticSignError = { bg = "#3c3a39", fg = colors.error_red },
        DiagnosticSignInfo = { bg = "#3c3a39", fg = colors.light_blue },
        DiagnosticSignHint = { bg = "#3c3a39", fg = colors.gray },
    }
    vim.cmd.colorscheme "gruvbox-baby"
end

return M
