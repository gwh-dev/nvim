local utils = require "core.utils"

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-telescope/telescope-fzy-native.nvim" },
    },
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
        { "<leader>/", utils.telescope "live_grep", desc = "Find in Files (Grep)" },
        { "<leader>sg", utils.telescope "live_grep", desc = "Grep (root dir)" },
        { "<leader>sG", utils.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
        { "<leader><space>", utils.telescope "files", desc = "Find Files (root dir)" },
        { "<leader>b", "<cmd>Telescope buffers theme=get_ivy<cr>", desc = "Telescope Buffers" },
    },
    config = function()
        local telescope = require "telescope"
        telescope.setup {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                mappings = {
                    n = {
                        ["q"] = function(...)
                            return require("telescope.actions").close(...)
                        end,
                    },
                    i = {
                        ["<C-i>"] = function()
                            utils.telescope("find_files", { no_ignore = true })()
                        end,
                        ["<C-h>"] = function()
                            utils.telescope("find_files", { hidden = true })()
                        end,
                        ["<C-Down>"] = function(...)
                            return require("telescope.actions").cycle_history_next(...)
                        end,
                        ["<C-Up>"] = function(...)
                            return require("telescope.actions").cycle_history_prev(...)
                        end,
                    },
                },
            },
            extensions = {
                fzy_native = {
                    override_generic_sorter = true,
                    override_file_sorter = true,
                },
            },
            pickers = {
                diagnostics = {
                    previewer = false,
                    initial_mode = "normal",
                },
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
    end,
}
