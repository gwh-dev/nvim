local lspconfig = require "lspconfig"
local null_ls = require "null-ls"

local lsp, cmd, fn = vim.lsp, vim.cmd, vim.fn
local buf_keymap = vim.api.nvim_buf_set_keymap

local diagnostic = {
  "Error",
  "Warn",
  "Info",
  "Hint",
}

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

local keymap_opts = { noremap = true, silent = true }
local function on_attach(client)
  buf_keymap(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", keymap_opts)
  buf_keymap(0, "n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", keymap_opts)
  buf_keymap(0, "n", "<leader>gd", '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>', keymap_opts)
  buf_keymap(0, "n", "<leader>gi", '<cmd>lua require"telescope.builtin".lsp_implementations()<CR>', keymap_opts)
  buf_keymap(0, "n", "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", keymap_opts)
  buf_keymap(0, "n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", keymap_opts)
  buf_keymap(0, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", keymap_opts)
  buf_keymap(0, "n", "<leader>gr", '<cmd>lua require"telescope.builtin".lsp_references()<CR>', keymap_opts)
  buf_keymap(0, "n", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", keymap_opts)
  buf_keymap(0, "v", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", keymap_opts)
  buf_keymap(0, "n", "]e", '<cmd>lua vim.diagnostic.goto_next { float = {scope = "line"} }<cr>', keymap_opts)
  buf_keymap(0, "n", "[e", '<cmd>lua vim.diagnostic.goto_prev { float = {scope = "line"} }<cr>', keymap_opts)

  if client.server_capabilities.documentFormattingProvider then
    buf_keymap(0, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format { async = true }<cr>", keymap_opts)
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
    cmd = { "lua-language-server" },
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
