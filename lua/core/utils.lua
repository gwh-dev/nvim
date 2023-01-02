local M = {}

function M.code_action(range_given, line1, line2)
    if range_given then
        vim.lsp.buf.range_code_action(nil, { line1, 0 }, { line2, math.huge })
    else
        vim.lsp.buf.code_action()
    end
end

local formatting = vim.lsp.buf.format and function()
    vim.lsp.buf.format { async = true }
end or vim.lsp.buf.formatting

local formatting_sync = vim.lsp.buf.format and function()
    vim.lsp.buf.format { async = false }
end or vim.lsp.buf.formatting_sync

function M.format_command(range_given, line1, line2, bang)
    if range_given then
        vim.lsp.buf.range_formatting(nil, { line1, 0 }, { line2, math.huge })
    elseif bang then
        formatting_sync()
    else
        formatting()
    end
end

return M
