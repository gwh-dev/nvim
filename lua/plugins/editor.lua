local function line_targets(winid, comp)
    local wininfo = vim.fn.getwininfo(winid)[1]
    local cur_line = vim.fn.line "."

    -- Get targets.
    local targets = {}
    local state = { lnum = -1 }

    while comp(state, wininfo, cur_line) do
        -- Skip folded ranges.
        local fold_end = vim.fn.foldclosedend(state.lnum)
        if fold_end ~= -1 then
            state.lnum = fold_end + 1
        else
            if state.lnum ~= cur_line then
                table.insert(targets, { pos = { state.lnum, 1 } })
            end
            state.lnum = state.lnum + 1
        end
    end

    if #targets == 0 then
        return
    end

    -- Sort them by vertical screen distance from cursor.
    local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]

    local screen_rows_from_cursor = function(t)
        local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
        return math.abs(cur_screen_row - t_screen_row)
    end

    table.sort(targets, function(t1, t2)
        return screen_rows_from_cursor(t1) < screen_rows_from_cursor(t2)
    end)

    return targets
end

local function leap_line_backward()
    local winid = vim.api.nvim_get_current_win()
    local comp = function(state, wininfo, line)
        if state.lnum == -1 then
            state.lnum = wininfo.topline
        end

        return state.lnum <= line
    end
    require("leap").leap {
        targets = line_targets(winid, comp),
        target_windows = { winid },
    }
end

local function leap_line_forward()
    local winid = vim.api.nvim_get_current_win()
    local comp = function(state, wininfo, line)
        if state.lnum == -1 then
            state.lnum = line
        end

        return state.lnum <= wininfo.botline
    end

    require("leap").leap {
        targets = line_targets(winid, comp),
        target_windows = { winid },
    }
end

return {

    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
    },

    {
        "danymat/neogen",
        keys = {
            {
                "<leader>cc",
                function()
                    require("neogen").generate {}
                end,
                desc = "Neogen Comment",
            },
        },
        opts = { snippet_engine = "luasnip" },
    },

    {
        "anuvyklack/windows.nvim",
        event = "WinNew",
        dependencies = {
            { "anuvyklack/middleclass" },
        },
        keys = { { "<leader>z", "<cmd>WindowsMaximize<cr>" } },
        config = function()
            vim.o.winwidth = 5
            vim.o.winminwidth = 5
            vim.o.equalalways = false
            require("windows").setup()
        end,
    },

    {
        "Wansmer/treesj",
        keys = { "<leader>m", mode = "n" },
        config = true,
    },

    {
        "nacro90/numb.nvim",
        event = "CmdlineEnter",
        config = true,
    },

    {
        "ojroques/nvim-bufdel",
        cmd = "BufDel",
        config = true,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        keys = {
            {
                "<leader>e",
                function()
                    require("neo-tree.command").execute { toggle = true, dir = require("core.utils").get_root() }
                end,
                desc = "NeoTree (root dir)",
            },
        },
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
        end,
        config = {
            filesystem = {
                follow_current_file = true,
                hijack_netrw_behavior = "open_current",
            },
            -- hide_root_node = false,
        },
    },

    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        keys = {
            { "gcc", mode = "n" },
            { "gbc", mode = "n" },
            { "gc", mode = "v" },
            { "gb", mode = "v" },
        },
        config = function()
            require("Comment").setup {
                ignore = "^$", -- ignore empty lines
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
    },

    {
        "dnlhc/glance.nvim",
        cmd = "Glance",
        config = true,
    },

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },

    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", [[<cmd>UndotreeToggle<CR>]], { silent = true } },
        },
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
    },

    {
        "simrat39/symbols-outline.nvim",
        keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
        config = true,
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true,
    },

    {
        "ggandor/leap.nvim",
        event = { "BufRead", "BufNewFile" },
        dependencies = {
            {
                "ggandor/flit.nvim",
                config = {
                    labeled_modes = "nv",
                    multiline = false,
                },
            },
        },
        config = function()
            require("leap").setup {
                opts = {
                    highlight_unlabeled_phase_one_targets = true,
                },
                safe_labels = {},
                --stylua: ignore
                labels = {"w","s","a","j","k","l","o","i","q","d","h","g","u","t","m","v","c","n",".","z","/","D","L",
                    "N","H","G","M","U","T","?","Z","J","K","O","I",
                },
            }

            vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
            vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
            vim.keymap.set({ "n", "x", "o" }, "J", leap_line_forward, { desc = "Jump to line below cursor" })
            vim.keymap.set({ "n", "x", "o" }, "K", leap_line_backward, { desc = "Jump to line above cursor" })
        end,
    },

    { "tpope/vim-repeat", event = "VeryLazy" },

    -- {
    --     "abecodes/tabout.nvim",
    --     event = "InsertEnter",
    --     config = true,
    -- },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {
                check_ts = true,
                ts_config = {
                    lua = { "string", "source" },
                    javascript = { "string", "template_string" },
                    java = false,
                },
                disable_filetype = { "TelescopePrompt" },
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "Search",
                    highlight_grey = "Comment",
                },
            }
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        keys = { { "<localleader>c", "<cmd>ColorizerToggle<cr>", desc = "Colorizer" } },
        config = {
            filetypes = { "*", "!lazy" },
            buftype = { "*", "!prompt", "!nofile" },
            user_default_options = {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = false, -- "Name" codes like Blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                AARRGGBB = false, -- 0xAARRGGBB hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- Available modes: foreground, background
                -- Available modes for `mode`: foreground, background,  virtualtext
                mode = "background", -- Set the display mode.
                virtualtext = "■",
            },
        },
    },

    -- better yank/paste
    {
        "kkharji/sqlite.lua",
        event = "BufReadPost",
        dependencies = {
            "gbprod/yanky.nvim",
        },
        config = function()
            require("yanky").setup {
                highlight = {
                    timer = 150,
                },
                ring = {
                    storage = "sqlite",
                },
            }

            -- stylua: ignore
            -- Yank to the clipboard
            vim.keymap.set({ "n", "x" }, "<leader>y", "\"+<Plug>(YankyYank)")
            -- stylua: ignore
            vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
            vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
            vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
            vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
            vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
            vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
            vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
            vim.keymap.set("n", "]p", "<Plug>(YankyPutAfterFilter)")
            vim.keymap.set("n", "[p", "<Plug>(YankyPutBeforeFilter)")
        end,
    },
}
