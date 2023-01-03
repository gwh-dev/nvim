local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    }
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("config.plugins", {
    defaults = { lazy = true },
    checker = { enabled = true },
    performance = {
        cache = { enabled = true },
        rtp = {
            disabled_plugins = {
                "gzip",
                "2html_plugin",
                "man",
                "matchit",
                "matchparen",
                "shada_plugin",
                "tarPlugin",
                "tar",
                "zipPlugin",
                "zip",
                "netrw",
                "netrwPlugin",
                "remote_plugins",
                "netrwSettings",
                "netrwFileHandlers",
                "fzf",
                "getscript",
                "getscriptPlugin",
                "logipat",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "tutor",
                "syntax",
                "rplugin",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
                "tohtml",
            },
        },
    },
    debug = false,
})
