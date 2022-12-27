local lsp = vim.lsp
local fn = vim.fn
local cmd = vim.cmd

cmd [[
packadd null-ls.nvim
packadd mason.nvim
packadd mason-lspconfig.nvim
packadd mason-null-ls.nvim
packadd fidget.nvim
]]

local diagnostic = { "Error", "Warn", "Info", "Hint" }
for _, type in pairs(diagnostic) do
    local hl = "DiagnosticSign" .. type
    fn.sign_define(hl, { numhl = hl })
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

require("fidget").setup {
    text = {
        spinner = "dots",
    },
    window = {
        blend = 0,
    },
    sources = {
        ["null-ls"] = { ignore = true },
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

    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
    map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")

    -- Diagnostics
    map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
    map("n", "]d", '<cmd>lua vim.diagnostic.goto_next { float = {scope = "line"} }<cr>')
    map("n", "[d", '<cmd>lua vim.diagnostic.goto_prev { float = {scope = "line"} }<cr>')

    -- Telescope
    map("n", "gd", '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>')
    map("n", "gi", '<cmd>lua require"telescope.builtin".lsp_implementations()<CR>')
    map("n", "gr", '<cmd>lua require"telescope.builtin".lsp_references()<CR>')

    if
        (cap.document_formatting or cap.document_range_formatting)
        or (cap.documentFormattingProvider or cap.documentRangeFormattingProvider)
    then
        cmd "command! -buffer -range -bang LspFormat lua require('core.utils').format(<line1>, <line2>, <count>, '<bang>' == '!')"
        map("n", "<leader>f", "<cmd>LspFormat<CR>")
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

local servers = {
    rust_analyzer = {},
    sumneko_lua = { --},
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
                        [fn.expand "$VIMRUNTIME/lua"] = true,
                        [fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                        [fn.stdpath "config" .. "/lua"] = true,
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

local capabilities = lsp.protocol.make_client_capabilities()

if not packer_plugins["cmp-nvim-lsp"].loaded then -- it's a global
    cmd [[packadd cmp-nvim-lsp]]
end

local client_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
client_capabilities.offsetEncoding = { "utf-8" }

require("mason").setup {
    ui = { border = "rounded" },
}

local mason_lspconfig = require "mason-lspconfig"
for server, config in pairs(servers) do
    mason_lspconfig.setup {
        ensure_installed = { server }, -- Make sure everything is installed
    }
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
    -- mason_lspconfig.setup_handlers {
    --     [server] = function()
    require("lspconfig")[server].setup(config)
    --     end,
    -- }
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

require("mason-null-ls").setup {
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = false,
}
