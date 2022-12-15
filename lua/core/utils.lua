local fn = vim.fn
local lsp = vim.lsp

local M = {}

function M.mkdir()
  local dir = fn.expand "<afile>:p:h"

  -- This handles URLs using netrw. See ':help netrw-transparent' for details.
  if dir:find "%l+://" == 1 then
    return
  end

  if fn.isdirectory(dir) == 0 then
    fn.mkdir(dir, "p")
  end
end

local formatting = lsp.buf.format and function()
  lsp.buf.format { async = true }
end or lsp.buf.formatting

local formatting_sync = lsp.buf.format and function()
  lsp.buf.format { async = false }
end or lsp.buf.formatting_sync

function M.format(range_given, line1, line2, bang)
  if range_given then
    lsp.buf.range_formatting(nil, { line1, 0 }, { line2, math.huge })
  elseif bang then
    formatting_sync()
  else
    formatting()
  end
end

function M.code_action(range_given, line1, line2)
  if range_given then
    lsp.buf.range_code_action(nil, { line1, 0 }, { line2, math.huge })
  else
    lsp.buf.code_action()
  end
end

return M
