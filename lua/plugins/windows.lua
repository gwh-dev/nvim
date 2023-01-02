local M = {
	"anuvyklack/windows.nvim",
	config = true,
	keys = { { "n", "<leader>z", "<cmd>WindowsMaximize<cr>" } },
	dependencies = {
		{ "anuvyklack/middleclass" },
	},
}

function M.config()
	vim.o.winwidth = 5
	vim.o.winminwidth = 5
	vim.o.equalalways = false
end

return M
