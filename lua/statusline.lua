local path_sep = require("plenary.path").path.sep
local fn = vim.fn
local api = vim.api
local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function mode()
	local current_mode = api.nvim_get_mode().mode
	return string.format("%s", modes[current_mode]):upper()
end

local function filesize()
	local file = vim.fn.expand "%:p"
	if file == nil or #file == 0 then
		return ""
	end
	local size = vim.fn.getfsize(file)
	if size <= 0 then
		return ""
	end

	local suffixes = { "b", "k", "m", "g" }

	local i = 1
	while size > 1024 and i < #suffixes do
		size = size / 1024
		i = i + 1
	end

	local format = i == 1 and "%d%s" or "%.1f%s"
	return string.format(format, size, suffixes[i])
end

local function lineinfo()
	return "%l:%c - %p%%"
end

local function get_relative_path_filename()
	local path_head = fn.expand "%:h"
	-- print("ph " .. path_head)
	if path_head ~= "" then
		path_head = path_head .. path_sep
	end

	return "%#StatusLineNC# " .. path_head .. "%*%#CursorLineNr#%t %*"
end

local function get_file_modified_status()
	return '%{&modified?"":""}'
end
--
local function get_file_help_status()
	return "%h"
end

local function fname()
	return string.format("%s%s %s", get_relative_path_filename(), get_file_modified_status(), get_file_help_status())
end

-- local function vcs()
-- 	local git_info = vim.b.gitsigns_status_dict
-- 	if not git_info or git_info.head == "" then
-- 		return ""
-- 	end
-- 	local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
-- 	local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
-- 	local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
-- 	if git_info.added == 0 then
-- 		added = ""
-- 	end
-- 	if git_info.changed == 0 then
-- 		changed = ""
-- 	end
-- 	if git_info.removed == 0 then
-- 		removed = ""
-- 	end
-- 	return table.concat {
-- 		" ",
-- 		added,
-- 		changed,
-- 		removed,
-- 		" ",
-- 		"%#GitSignsAdd# ",
-- 		git_info.head,
-- 		" %#Normal#",
-- 	}
-- end

local function lsp_progress()
	local msg = "No Client"
	local buf_ft = api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()

	if next(clients) == nil then
		return "%#StatusLineNC# " .. msg
	end

	local lsp = vim.lsp.util.get_progress_messages()[1]
	if lsp then
		local name = lsp.name or ""
		msg = lsp.message or ""
		local percentage = lsp.percentage or 0
		local title = ("%#StatusLineNC# " .. lsp.title) or ""
		return string.format("%%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
	else
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
	end
	return ""
end

local function diagnostic_status()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsWarning# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsHint# " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsInformation# " .. count["info"]
	end

	local diagnostic_list = {
		errors,
		warnings,
		hints,
		info,
	}
	-- return errors .. warnings .. hints .. info .. " "
	return table.concat(diagnostic_list, "")
end

local function status()
	local parts = {
		-- Here goes the parts from before
		mode(), -- Mode changer
		"%#StatusLineNC#",
		" |",
		fname(),
		"%#StatusLineNC#",
		" | ",
		"%#StatusLine#",
		string.upper(lsp_progress()),
		"%=", -- To make a large space everything down is on the right side
		-- "%#CursorLineNr#% ",
		-- lsp_progress(),
		diagnostic_status(), -- If I didn't put the 'Statusline' highlight, It will change the lineinfo with diagnostic_status colors
		"%#StatusLineNC#",
		" | ",
		"%#StatusLine#", -- Changing the colorscheme for lineinfo to 'Statusline' The normal color
		lineinfo(), -- {col number} { the place using % }
		"%#StatusLineNC#",
		" | ",
		"%#StatusLine#", -- Changing the colorscheme for lineinfo to 'Statusline' The normal color
		filesize(),
	}
	return table.concat(parts, "")
end

return { status = status }
