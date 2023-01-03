return {
    "ggandor/leap.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
    dependencies = {
        {
            "ggandor/flit.nvim",
            config = {
                labeled_modes = "nv",
            },
        },
    },
    config = function()
        require("leap").add_default_mappings()
    end,
}
