local lsp = vim.lsp
local fn = vim.fn
local cmd = vim.cmd

local diagnostic = { "Error", "Warn", "Info", "Hint" }
for _, type in pairs(diagnostic) do
  local hl = "DiagnosticSign" .. type
  fn.sign_define(hl, { numhl = hl, texthl = hl })
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

lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
  vim.notify(method.message, (diagnostic)[params.type])
end

require("lsp_signature").setup { bind = true, handler_opts = { border = "rounded" }, toggle_key = "<C-k>" }
local function on_attach(client, bufnr)
  local map = function(m, lhs, rhs)
    local opts = { remap = false, silent = true, buffer = bufnr }
    vim.keymap.set(m, lhs, rhs, opts)
  end

  -- LSP actions
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

  map("n", "<leader>a", function()
    require("core.utils").code_action()
  end)

  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
  map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")

  -- Not used
  -- map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
  -- map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
  -- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
  -- map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

  -- Diagnostics
  map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
  map("n", "]d", '<cmd>lua vim.diagnostic.goto_next { float = {scope = "line"} }<cr>')
  map("n", "[d", '<cmd>lua vim.diagnostic.goto_prev { float = {scope = "line"} }<cr>')

  -- Telescope
  map("n", "gd", '<cmd>lua require"telescope.builtin".lsp_definitions()<CR>')
  map("n", "gi", '<cmd>lua require"telescope.builtin".lsp_implementations()<CR>')
  map("n", "gr", '<cmd>lua require"telescope.builtin".lsp_references()<CR>')

  if client.server_capabilities.documentFormattingProvider then
    map("n", "<leader>f", function()
      require("core.utils").format()
    end)
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
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
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

local capabilities = lsp.protocol.make_client_capabilities()

if not packer_plugins["cmp-nvim-lsp"].loaded then
  cmd [[packadd cmp-nvim-lsp]]
end

local client_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
client_capabilities.offsetEncoding = { "utf-8" }

require("mason").setup {
  ui = { border = "rounded" },
}

for server, config in pairs(servers) do
  require("mason-lspconfig").setup {
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
  require("mason-lspconfig").setup_handlers {
    require("lspconfig")[server].setup(config),
  }
end

-- null-ls setup
local null_ls = require "null-ls"
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- local code_action = null_ls.builtins.code_actions

null_ls.setup {
  sources = {
    formatting.prettier,
    formatting.rustfmt,
    formatting.shfmt,
    formatting.stylua,
    diagnostics.selene,
  },
  on_attach = on_attach,
}

require("mason-null-ls").setup {
  ensure_installed = nil,
  automatic_installation = true,
  automatic_setup = false,
}
