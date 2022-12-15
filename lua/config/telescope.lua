local telescope = require("telescope")

telescope.setup({
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
		selection_caret = " ",
		entry_prefix = " ",
		defaults = {
			layout_strategy = "flex",
			layout_config = { anchor = "N" },
			scroll_strategy = "cycle",
			theme = require("telescope.themes").get_dropdown({ layout_config = { prompt_position = "top" } }),
		},
	},
	extensions = {
		fzy = {
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
	},
	mappings = {
		n = { ["q"] = require("telescope.actions").close },
	},
})
telescope.load_extension("fzy_native")
