return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-lua/popup.nvim" },
        { "nvim-telescope/telescope-fzy-native.nvim" }
    },
    cmd = "Telescope",
    keys = {
        { "<leader>d", [[<cmd>Telescope diagnostics theme=get_ivy<CR>]], { silent = true } },
        { "<leader>b", [[<cmd>Telescope buffers theme=get_ivy<CR>]], { silent = true } },
        { "<leader>i", [[<cmd>Telescope find_files theme=get_dropdown<CR>]], { silent = true } },
        { "<leader>g", [[<cmd>Telescope live_grep<CR>]], { silent = true } },
    },
    config = function()
        local telescope = require "telescope"

        telescope.setup {
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                prompt_prefix = " ",
                selection_caret = " ",
                entry_prefix = " ",
                layout_strategy = "flex",
                layout_config = { anchor = "N" },
                scroll_strategy = "cycle",
                theme = require("telescope.themes").get_dropdown { layout_config = { prompt_position = "top" } },
            },
            extensions = {
                fzy_native = {
                    override_generic_sorter = true,
                    override_file_sorter = true,
                },
            },
            pickers = {
                buffers = {
                    initial_mode = "normal",
                    ignore_current_buffer = true,
                    -- sort_mru = true,
                    sort_lastused = true,
                    previewer = false,
                },
                find_files = {
                    initial_mode = "normal",
                    previewer = false,
                },
            },
        }
        telescope.load_extension "fzy_native"
    end
}
