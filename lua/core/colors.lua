local g = vim.g
-- -- foreground option can be material, mix, or original
g.gruvbox_material_foreground = "material"
-- background option can be hard, medium, soft
g.gruvbox_material_background = "soft"
g.gruvbox_material_enable_italic = 1
g.gruvbox_material_better_performance = 1

vim.cmd.colorscheme [[gruvbox-material]]

-- local ok, catppuccin = pcall(require, "catppuccin")
-- if not ok then
--     return
-- end
-- catppuccin.setup {
--     term_colors = true,
--     integrations = {
--         treesitter = true,
--         mason = true,
--         cmp = true,
--         telescope = true,
--         fidget = true,
--         native_lsp = { enabled = true },
--         --
--         dap = { enabled = false, enable_ui = false },
--         aerial = false,
--         navic = { enabled = false },
--         indent_blankline = { enabled = false },
--         barbar = false,
--         beacon = false,
--         dashboard = false,
--         fern = false,
--         harpoon = false,
--         hop = false,
--         leap = false,
--         lightspeed = false,
--         markdown = false,
--         neotree = false,
--         neogit = false,
--         neotest = false,
--         noice = false,
--         semantic_tokens = false,
--         treesitter_context = false,
--         ts_rainbow = false,
--         overseer = false,
--         pounce = false,
--         symbols_outline = false,
--         telekasten = false,
--         lsp_trouble = false,
--         gitgutter = false,
--         illuminate = false,
--         vim_sneak = false,
--         vimwiki = false,
--         which_key = false,
--         gitsigns = false,
--         nvimtree = false,
--         notify = false,
--         mini = false,
--         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--     },
-- }
-- catppuccin.load "frappe"
