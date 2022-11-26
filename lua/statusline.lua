-- local colors = require("catppuccin.palettes").get_palette()

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
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format("%s", modes[current_mode]):upper()
end

local function filename()
	local fname = vim.fn.expand "%:t"
	if fname == "" then
		return ""
	end
	return string.upper(fname)
end

local function lineinfo()
	return "%c %P"
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
		errors = " %#LspDiagnosticsError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsWarning# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsHint# " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsInformation# " .. count["info"]
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
		" ", -- Make a small space in the left side
		mode(), -- Mode changer
		"┃",
		filename(),
		"%=", -- To make a large space everything down is on the right side
		diagnostic_status(), -- If I didn't put the 'Statusline' highlight, It will change the lineinfo with diagnostic_status colors
		"%#StatusLine#", -- Changing the colorscheme for lineinfo to 'Statusline' The normal color
		"┃",
		lineinfo(), -- {col number} { the place using % }
		" ", -- A small space in the right side
	}
	return table.concat(parts, " ")
end

return { status = status }
