local M = {
    "folke/noice.nvim",
    event = "VeryLazy",
}

function M.config()
    local focused = true
    vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
            focused = true
        end,
    })
    vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
            focused = false
        end,
    })
    require("noice").setup {
        debug = false,
        views = {
            cmdline_popup = {
                backend = "popup",
                relative = "editor",
                focusable = false,
                enter = false,
                zindex = 60,
                position = {
                    row = "50%",
                    col = "50%",
                },
                size = {
                    min_width = 60,
                    width = "auto",
                    height = "auto",
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = {
                        Normal = "NormalFloat",
                        FloatBorder = "NormalFloat", -- shouldn't this clear guifg?
                        IncSearch = "",
                        Search = "",
                    },
                    cursorline = false,
                },
            },
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        routes = {
            {
                filter = {
                    cond = function()
                        return not focused
                    end,
                },
                view = "notify_send",
                opts = { stop = false },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "%d+L, %d+B",
                },
                view = "mini",
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = true,
            cmdline_output_to_split = false,
        },
        commands = {
            all = {
                -- options for the message history that you get with `:Noice`
                view = "split",
                opts = { enter = true, format = "details" },
                filter = {},
            },
        },
        format = {
            level = {
                icons = false,
            },
        },
    }

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
            vim.schedule(function()
                require("noice.text.markdown").keys(event.buf)
            end)
        end,
    })
end

return M
