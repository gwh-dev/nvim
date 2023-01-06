local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",

    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "williamboman/mason.nvim", config = true },
        { "williamboman/mason-lspconfig.nvim" },
        {
            "jose-elias-alvarez/null-ls.nvim",
            -- Null-ls Tools
            tools = {
                "prettierd",
                "stylua",
                "selene",
                "luacheck",
                "eslint_d",
                "shellcheck",
                "deno",
                "shfmt",
                "black",
                "isort",
                "flake8",
            },

            config = function(plugin)
                -- null-ls setup
                local null_ls = require "null-ls"
                local formatting = null_ls.builtins.formatting
                local diagnostics = null_ls.builtins.diagnostics
                -- local code_actions = null_ls.builtins.code_actions
                null_ls.setup {
                    sources = {
                        formatting.prettier,
                        formatting.rustfmt,
                        formatting.shfmt,
                        formatting.stylua,
                        formatting.cbfmt,
                        diagnostics.selene,
                    },
                }
                require("plugins.lsp.utils").ensure_tools_installed(plugin.tools)
            end,
        },
    },

    -- Lsp Config Servers
    servers = {
        rust_analyzer = {},
        sumneko_lua = {
            prefer_null_ls = true,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = vim.split(package.path, ";"),
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = {
                            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                            [vim.fn.stdpath "config" .. "/lua"] = true,
                        },
                    },
                },
            },
        },
        gopls = {
            cmd = { "gopls", "--remote=auto" },
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
            },
        },
        jsonls = {},
    },

    config = function(plugin)
        require("plugins.lsp.handlers").setup(plugin.servers)
        require("plugins.lsp.utils").on_attach(function(client, bufnr)
            require("plugins.lsp.utils").autoformat(client, bufnr)
            require("plugins.lsp.mappings").on_attach(client, bufnr)
        end)
    end,
}

return M
