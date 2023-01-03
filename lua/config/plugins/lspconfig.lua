local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    dependencies = {
    },
}

M.servers = {
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
}

M.tools = {
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
}

function M.check()
    local mr = require "mason-registry"
    for _, tool in ipairs(M.tools) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
            p:install()
        end
    end
end

function M.config()
    local lsp = vim.lsp
    local cmd = vim.cmd
    local diagnostic = { "Error", "Warn", "Info", "Hint" }
    for _, type in pairs(diagnostic) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { numhl = hl })
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

    lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
        border = "rounded",
    })

    lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
        border = "rounded",
    })

    local function on_attach(client, bufnr)
        local cap = client.server_capabilities
        local map = function(m, lhs, rhs)
            local opts = { remap = false, silent = true, buffer = bufnr }
            vim.keymap.set(m, lhs, rhs, opts)
        end
        -- LSP
        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
        map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
        map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")

        map("n", "gd", "<cmd>Glance definitions<cr>")
        map("n", "gr", "<cmd>Glance references<cr>")
        map("n", "go", "<cmd>Glance type_definitions<cr>")
        map("n", "gi", "<cmd>Glance implementations<cr>")

        -- Diagnostics
        map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
        map("n", "]d", '<cmd>lua vim.diagnostic.goto_next { float = {scope = "line"} }<cr>')
        map("n", "[d", '<cmd>lua vim.diagnostic.goto_prev { float = {scope = "line"} }<cr>')

        -- Disable
        -- map("n", "gd", "<cmd>Trouble lsp_definitions<cr>")
        -- map("n", "gr", "<cmd>Trouble references<cr>")
        -- map("n", "go", "<cmd>Trouble type_definitions<cr>")
        -- map("n", "gi", "<cmd>Trouble implementations<cr>")
        -- map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
        -- map("n", "gd", '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>')
        -- map("n", "gi", '<cmd>lua require"telescope.builtin".lsp_implementations()<CR>')
        -- map("n", "gr", '<cmd>lua require"telescope.builtin".lsp_references()<CR>')

        if
            (cap.document_formatting or cap.document_range_formatting)
            or (cap.documentFormattingProvider or cap.documentRangeFormattingProvider)
        then
            cmd 'command! -buffer -range -bang LspFormat lua require("core.utils").format_command(<range> ~= 0, <line1>, <line2>, "<bang>" == "!")'
            map("n", "<leader>f", "<cmd>LspFormat<cr>")
        end

        if cap.code_action or cap.codeActionProvider then
            cmd 'command! -buffer -range LspCodeAction lua require("core.utils").code_action(<range> ~= 0, <line1>, <line2>)'
            map("n", "<leader>a", "<cmd>LspCodeAction<CR>")
        end

        cmd "augroup lsp_aucmds"
        if cap.documentHighlightProvider then
            cmd "au CursorHold <buffer> lua vim.lsp.buf.document_highlight()"
            cmd "au CursorMoved <buffer> lua vim.lsp.buf.clear_references()"
        end
        cmd "augroup END"

        if cap.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end
    end

    local function prefer_null_ls_fmt(client)
        local cap = client.server_capabilities
        -- cap.code_action = false
        -- cap.codeActionProvider = false
        cap.documentHighlightProvider = false
        cap.documentFormattingProvider = false
        cap.documentRangeFormattingProvider = false
        cap.document_formatting = false
        cap.document_range_formatting = false
        cap.documentSymbolProvider = false
        on_attach(client)
    end

    local capabilities = lsp.protocol.make_client_capabilities()

    local client_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    client_capabilities.offsetEncoding = { "utf-8" }

    M.check()
    for server, config in pairs(M.servers) do
        if config.prefer_null_ls then
            if config.on_attach then
                local old_on_attach = config.on_attach
                config.on_attach = function(client, bufnr)
                    old_on_attach(client, bufnr)
                    prefer_null_ls_fmt(client)
                end
            else
                config.on_attach = prefer_null_ls_fmt
            end
        elseif not config.on_attach then
            config.on_attach = on_attach
        end

        config.capabilities = vim.tbl_deep_extend("keep", config.capabilities or {}, client_capabilities)
        require("lspconfig")[server].setup(config)
    end

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
            -- code_actions.refactoring,
        },
        on_attach = on_attach,
    }
end

return M
