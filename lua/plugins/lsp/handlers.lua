local M = {}

function M.setup(servers)
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

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })

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
end

return M
