return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            {
                "kosayoda/nvim-lightbulb",
                init = function()
                    vim.fn.sign_define("LightBulbSign", { text = "ﯧ", texthl = "@class" })
                end,
            },
        },
        servers = {
            rust_analyzer = {},
            sumneko_lua = {
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
                            checkThirdParty = false,
                            -- Make the server aware of Neovim runtime files
                            library = {
                                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                                [vim.fn.stdpath "config" .. "/lua"] = true,
                            },
                        },
                        completion = {
                            callSnippet = "Replace",
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
            -- setup formatting and keymaps
            require("core.utils").on_attach(function(client, buffer)
                require("plugins.lsp.format").on_attach(client, buffer)
                require("plugins.lsp.mappings").on_attach(client, buffer)
                require("nvim-lightbulb").setup { autocmd = { enabled = true } }
            end)

            local diagnostic = { "Error", "Warn", "Info", "Hint" }
            for _, type in pairs(diagnostic) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { numhl = hl, culhl = hl, texthl = hl, linehl = hl })
            end
            vim.diagnostic.config {
                virtual_text = false,
                signs = true,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            }

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded",
            })

            local servers = plugin.servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local client_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            require("mason-lspconfig").setup { ensure_installed = vim.tbl_keys(servers) }
            require("mason-lspconfig").setup_handlers {
                function(server)
                    local config = servers[server] or {}
                    config.capabilities = client_capabilities
                    require("lspconfig")[server].setup(config)
                end,
            }
        end,
    },

    -- formatters
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        dependencies = { "mason.nvim" },
        config = function()
            local nls = require "null-ls"
            local formatting = nls.builtins.formatting
            local diagnostics = nls.builtins.diagnostics
            local code_actions = nls.builtins.code_actions
            nls.setup {
                debounce = 150,
                save_after_format = false,
                sources = {
                    formatting.prettier,
                    formatting.rustfmt,
                    formatting.shfmt,
                    formatting.stylua,
                    formatting.cbfmt,
                    diagnostics.selene,
                    diagnostics.flake8,
                    -- code_actions.gitsigns,
                    formatting.prettierd,
                },
            }
        end,
    },

    -- cmdline tools and lsp servers
    {

        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<localleader>m", "<cmd>Mason<cr>", desc = "Mason" } },
        tools = {
            -- Null-ls Tools
            "prettierd",
            "prettier",
            "stylua",
            "selene",
            "luacheck",
            "eslint_d",
            "shellcheck",
            "deno",
            "shfmt",
            "cbfmt",
            "black",
            "isort",
            "flake8",
        },
        config = function(plugin)
            require("mason").setup()
            local mr = require "mason-registry"
            for _, tool in ipairs(plugin.tools) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },

    {
        "SmiteshP/nvim-navic",
        init = function()
            vim.g.navic_silence = true
            require("core.utils").on_attach(function(client, buffer)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, buffer)
                end
            end)
        end,
        config = {
            icons = {
                File = "file ",
                Module = "module ",
                Namespace = "namespace ",
                Package = "package ",
                Class = "class ",
                Method = "method ",
                Property = "property ",
                Field = "field ",
                Constructor = "constructor ",
                Enum = "enum ",
                Interface = "interface ",
                Function = "function ",
                Variable = "variable ",
                Constant = "constant ",
                String = "string ",
                Number = "number ",
                Boolean = "boolean ",
                Array = "array ",
                Object = "object ",
                Key = "key ",
                Null = "null ",
                EnumMember = "enum member ",
                Struct = "struct ",
                Event = "event ",
                Operator = "operator ",
                TypeParameter = "type parameter ",
            },
            highlight = true,
            separator = " " .. "❭" .. " ",
            depth_limit = 5,
            depth_limit_indicator = "..",
        },
    },
}
