-- require("neodev").setup { lspconfig = { cmd = { "lua-language-server" }, prefer_null_ls = true } }
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
-- local colors = require("catppuccin.palettes").get_palette "frappe"

local lsp = vim.lsp
local cmd = vim.cmd
local fn = vim.fn
local buf_keymap = vim.api.nvim_buf_set_keymap

vim.diagnostic.config({
    signs = false,
    virtual_lines = { only_current_line = true },
    virtual_text = false,
})

lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
    border = "rounded",
})

lsp.handlers["textDocument/signatureHelp"] =
    lsp.with(lsp.handlers.signature_help, {
        border = "rounded",
    })

lsp.handlers["textDocument/publishDiagnostics"] =
    lsp.with(lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = false,
        update_in_insert = false,
        underline = true,
    })

local severity = {
    "error",
    "warn",
    "info",
    "hint",
}

lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
    vim.notify(method.message, severity[params.type])
end

local keymap_opts = { noremap = true, silent = true }
local function on_attach(client)
    buf_keymap(
        0,
        "n",
        "gD",
        "<cmd>lua vim.lsp.buf.declaration()<CR>",
        keymap_opts
    )
    buf_keymap(
        0,
        "n",
        "gd",
        '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>',
        keymap_opts
    )
    buf_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", keymap_opts)
    buf_keymap(
        0,
        "n",
        "gi",
        '<cmd>lua require"telescope.builtin".lsp_implementations()<CR>',
        keymap_opts
    )
    buf_keymap(
        0,
        "n",
        "gS",
        "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        keymap_opts
    )
    buf_keymap(
        0,
        "n",
        "gTD",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        keymap_opts
    )
    buf_keymap(
        0,
        "n",
        "<leader>rn",
        "<cmd>lua vim.lsp.buf.rename()<CR>",
        keymap_opts
    )
    buf_keymap(
        0,
        "n",
        "gr",
        '<cmd>lua require"telescope.builtin".lsp_references()<CR>',
        keymap_opts
    )
    buf_keymap(
        0,
        "n",
        "gA",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        keymap_opts
    )
    buf_keymap(
        0,
        "v",
        "gA",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        keymap_opts
    )
    buf_keymap(
        0,
        "n",
        "]e",
        '<cmd>lua vim.diagnostic.goto_next { float = {scope = "line"} }<cr>',
        keymap_opts
    )
    buf_keymap(
        0,
        "n",
        "[e",
        '<cmd>lua vim.diagnostic.goto_prev { float = {scope = "line"} }<cr>',
        keymap_opts
    )

    if client.server_capabilities.documentFormattingProvider then
        buf_keymap(
            0,
            "n",
            "<leader>f",
            "<cmd>lua vim.lsp.buf.format { async = true }<cr>",
            keymap_opts
        )
    end

    cmd("augroup lsp_aucmds")
    if client.server_capabilities.documentHighlightProvider then
        cmd("au CursorHold <buffer> lua vim.lsp.buf.document_highlight()")
        cmd("au CursorMoved <buffer> lua vim.lsp.buf.clear_references()")
    end
    cmd("augroup END")
end

local function prefer_null_ls_fmt(client)
    client.server_capabilities.documentHighlightProvider = false
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client)
end

local servers = {
    sumneko_lua = {
        prefer_null_ls = true,
        cmd = { "lua-language-server" },
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
                runtime = { version = "LuaJIT" },
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
                        lsp.buf.range_formatting(
                            {},
                            { 0, 0 },
                            { fn.line("$"), 0 }
                        )
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

    config.capabilities = vim.tbl_deep_extend(
        "keep",
        config.capabilities or {},
        client_capabilities
    )
    lspconfig[server].setup(config)
end

-- null-ls setup
local null_fmt = null_ls.builtins.formatting
local null_diag = null_ls.builtins.diagnostics
local null_act = null_ls.builtins.code_actions
null_ls.setup({
    sources = {
        null_fmt.prettier,
        null_fmt.rustfmt,
        null_fmt.shfmt,
        null_fmt.stylua,

        null_act.gitsigns,

        null_diag.selene,
    },
    on_attach = on_attach,
})
