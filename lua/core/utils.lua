local M = {}

function M.code_action(range_given, line1, line2)
	if range_given then
		vim.lsp.buf.range_code_action(nil, { line1, 0 }, { line2, math.huge })
	else
		vim.lsp.buf.code_action()
	end
end

-- M.format_cmd = function(line1, line2, count, bang)
function M.format(line1, line2, count, bang)
	local execute = vim.lsp.buf.format

	if execute then
		execute({ async = bang })
		return
	end

	local has_range = line2 == count
	execute = vim.lsp.buf.formatting

	if bang then
		if has_range then
			local msg = "Synchronous formatting doesn't support ranges"
			vim.notify(msg, vim.log.levels.ERROR)
			return
		end
		execute = vim.lsp.buf.formatting_sync
	end

	if has_range then
		execute = vim.lsp.buf.range_formatting
	end

	execute()
end

return M
