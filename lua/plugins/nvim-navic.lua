return {
	"SmiteshP/nvim-navic",
	config = function()
		vim.g.navic_silence = true
		local navic = require("nvim-navic")
		navic.setup({
			icons = {
				File = "file ",
				Module = "module ",
				Namespace = "namespace ",
				Package = "package ",
				Class = "class ",
				Method = "method ",
				Property = "property ",
				Field = "field ",
				Constructor = "constructor ",
				Enum = "enum ",
				Interface = "interface ",
				Function = "function ",
				Variable = "variable ",
				Constant = "constant ",
				String = "string ",
				Number = "number ",
				Boolean = "boolean ",
				Array = "array ",
				Object = "object ",
				Key = "key ",
				Null = "null ",
				EnumMember = "enum member ",
				Struct = "struct ",
				Event = "event ",
				Operator = "operator ",
				TypeParameter = "type parameter ",
			},
			highlight = true,
			separator = " " .. "❭" .. " ",
			depth_limit = 0,
			depth_limit_indicator = "..",
		})
	end,
}
