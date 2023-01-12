local Menu = require "nui.menu"

local M = {}

local select_menu = nil

vim.ui.select = function(items, opts, on_choice)
    if select_menu then
        error "Busy!"
    end

    local max_length = vim.api.nvim_win_get_width(0)

    opts = opts or {}

    local format_item = opts.format_item or tostring

    local lines = {}

    for _, item in pairs(items) do
        local item_text = string.sub(format_item(item), 0, max_length - 2)
        table.insert(lines, Menu.item(item_text, item))
    end

    select_menu = Menu({
        relative = "cursor",
        position = {
            row = 1,
            col = 0,
        },
        border = {
            style = "rounded",
            highlight = "Normal",
            text = {
                top = opts.prompt or "[Choose Item]",
                top_align = "left",
            },
        },
        highlight = "Normal:Normal",
    }, {
        lines = lines,
        separator = {
            char = "-",
            text_align = "right",
        },
        keymap = {
            focus_next = { "j", "<Down>", "<Tab>" },
            focus_prev = { "k", "<Up>", "<S-Tab>" },
            close = { "<Esc>", "<C-c>" },
            submit = { "<CR>", "<Space>" },
        },
        on_close = function()
            on_choice(nil, nil)
            select_menu = nil
        end,
        on_submit = function(item)
            on_choice(item, item._index)
            select_menu = nil
        end,
    })

    select_menu:mount()
end

return M
