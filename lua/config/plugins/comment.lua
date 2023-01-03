return {
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
}
