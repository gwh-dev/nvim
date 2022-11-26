local telescope = require "telescope"
-- local actions = require "telescope.actions"
local trouble = require "trouble.providers.telescope"

telescope.setup {
	defaults = {
		layout_strategy = "flex",
		layout_config = { anchor = "N" },
		scroll_strategy = "cycle",
		theme = require("telescope.themes").get_dropdown { layout_config = { prompt_position = "top" } },
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown { layout_config = { prompt_position = "top" } },
		},
	},
	pickers = {
		buffers = {
			ignore_current_buffer = true,
			-- sort_mru = true,
			sort_lastused = true,
			previewer = false,
		},
	},
}

telescope.load_extension "fzf"
telescope.load_extension "ui-select"
