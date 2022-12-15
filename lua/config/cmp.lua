local luasnip = require "luasnip"

luasnip.setup { region_check_events = "InsertEnter", delete_check_events = "InsertEnter" }
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require "cmp"
local lspkind = require "lspkind"
local types = require "cmp.types"
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require("cmp-under-comparator").under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = "path" },
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "nvim_lua", keyword_length = 3 },
    { name = "buffer", keyword_length = 3 },
    { name = "luasnip", keyword_length = 2 },
  },
  window = {
    documentation = vim.tbl_deep_extend("force", cmp.config.window.bordered(), {
      max_height = 15,
      max_width = 60,
    }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format { mode = "symbol_text", maxwidth = 50 }(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      local word = entry:get_insert_text()
      if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
        word = vim.lsp.util.parse_snippet(word)
      end
      kind.kind = " " .. strings[1] .. " "
      kind.menu = " [" .. strings[2] .. "] "
      if
        entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
        and string.sub(kind.abbr, -1, -1) == "~"
      then
        word = word .. "~"
      end
      kind.abbr = word
      return kind
    end,
  },
  mapping = {
    -- confirm selection
    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<C-y>"] = cmp.mapping.confirm { select = true },

    -- complete selection
    ["<C-Space>"] = cmp.mapping.complete(),

    -- navigate items on the list
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select_opts),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select_opts),

    -- scroll up and down in the completion documentation
    ["<C-f>"] = cmp.mapping.scroll_docs(5),
    ["<C-u>"] = cmp.mapping.scroll_docs(-5),

    ["<Tab>"] = cmp.mapping(function(fallback)
      local col = vim.fn.col "." - 1

      if cmp.visible() then
        cmp.select_next_item(cmp_select_opts)
      elseif col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
        fallback()
      else
        cmp.complete()
      end
    end, { "i", "s" }),

    -- when menu is visible, navigate to previous item on list
    -- else, revert to default behavior
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(cmp_select_opts)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
}

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline", keyword_length = 2 } }),
})
