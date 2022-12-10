local lsp, cmd, fn = vim.lsp, vim.cmd, vim.fn
local lspconfig = require "lspconfig"
local null_ls = require "null-ls"
-- local saga = require "lspsaga"

local diagnostic = {
    "Error",
    "Warn",
    "Info",
    "Hint",
}

-- saga.init_lsp_saga {
--     symbol_in_winbar = {
--         in_custom = true,
--         separator = " » ",
--     },
--     code_action_lightbulb = {
--         enable_in_insert = false,
--         virtual_text = false,
--     },
--     code_action_icon = "",
--     custom_kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
-- }

for _, type in pairs(diagnostic) do
    local hl = "DiagnosticSign" .. type
    fn.sign_define(hl, { numhl = hl })
end

vim.diagnostic.config {
    signs = true,
    virtual_lines = { only_current_line = true },
    virtual_text = true,
    underline = true,
}

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    virtual_text = true,
    update_in_insert = false,
    underline = true,
})

local map = vim.keymap.set
local opts = { buffer = true, noremap = true, silent = true }
local function on_attach(client)
    -- map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
    -- map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
    -- map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
    -- map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
    -- map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    -- map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    -- map("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
    -- map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    -- -- TODO: Make it automaticly
    -- map("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
    -- map("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
    -- map("n", "<leader>gd", '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>', keymap_opts)
    -- map("n", "<leader>gi", '<cmd>lua require"telescope.builtin".lsp_implementations()<CR>', keymap_opts)
    -- map("n", "<leader>gr", '<cmd>lua require"telescope.builtin".lsp_references()<CR>', keymap_opts)
    -- map("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", keymap_opts)
    -- map("n", "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", keymap_opts)
    -- map("n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", keymap_opts)

    if client.server_capabilities.documentFormattingProvider then
        map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format { async = true }<cr>", opts)
    end

    cmd "augroup lsp_aucmds"
    if client.server_capabilities.documentHighlightProvider then
        cmd "au CursorHold <buffer> lua vim.lsp.buf.document_highlight()"
        cmd "au CursorMoved <buffer> lua vim.lsp.buf.clear_references()"
    end
    cmd "augroup END"
end

local function prefer_null_ls_fmt(client)
    client.server_capabilities.documentHighlightProvider = false
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client)
end

local servers = {
    sumneko_lua = {
        prefer_null_ls = true,
        cmd = { "/home/gwh/Downloads/lua-language-server/bin/lua-language-server" },
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
    jsonls = {
        -- settings = {
        -- 	json = {
        -- 		schemas = require("schemastore").json.schemas(),
        -- 		validate = { enable = true },
        -- 	},
        -- },
        setup = {
            commands = {
                Format = {
                    function()
                        lsp.buf.range_formatting({}, { 0, 0 }, { fn.line "$", 0 })
                    end,
                },
            },
        },
    },
}

local client_capabilities = require("cmp_nvim_lsp").default_capabilities()
client_capabilities.offsetEncoding = { "utf-8" }

for server, config in pairs(servers) do
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
    lspconfig[server].setup(config)
end

-- null-ls setup
local null_fmt = null_ls.builtins.formatting
local null_diag = null_ls.builtins.diagnostics
-- local null_act = null_ls.builtins.code_actions
null_ls.setup {
    sources = {
        null_fmt.prettier,
        null_fmt.rustfmt,
        null_fmt.shfmt,
        null_fmt.stylua,
        null_diag.selene,
        -- null_act.gitsigns,
    },
    on_attach = on_attach,
}
