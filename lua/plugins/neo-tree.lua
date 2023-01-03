vim.cmd "lua vim.g.neo_tree_remove_legacy_commands = 1"
return {
    "nvim-neo-tree/neo-tree.nvim",
    -- cmd = "Neotree",
    keys = {
        { "<leader>e", [[<cmd>Neotree toggle<cr>]], desc = "File Browser" },
    },
    config = {
        -- window = {
        --     position = "float",
        --     popup = {
        --         position = { row = "10%", col = "100%" },
        --         size = function(state)
        --             local root_name = vim.fn.fnamemodify(state.path, ":~")
        --             local root_len = string.len(root_name) + 2
        --             return {
        --                 width = math.max(root_len, 32),
        --                 height = "50%",
        --             }
        --         end,
        --         border = { style = "rounded" },
        --     },
        -- },
        filesystem = {
            follow_current_file = true,
            hijack_netrw_behavior = "open_current",
        },
    },
}
