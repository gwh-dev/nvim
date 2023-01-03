return {
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
}
