local M = {
    "j-hui/fidget.nvim",
    config = {
        text = {
            spinner = "dots",
        },
        window = {
            blend = 0,
        },
        sources = {
            ["null-ls"] = { ignore = true },
        },
    },
}
return M
