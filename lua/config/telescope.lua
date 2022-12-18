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
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
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
            previewer = false,
        },
    },
}

telescope.load_extension "fzf"
