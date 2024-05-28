local M = {}

--- @param o MilspecOptions
--- @param c MilspecColors
--- @return table<string, vim.api.keyset.highlight>
function M.get(o, c)
	return {
		-- any comment
		Comment = { fg = c.gray },

		-- any constant
		Constant = { fg = c.vermilion },

		-- a string constant: "this is a string"
		String = { fg = c.green },
		-- a character constant: 'c', '\n'
		Character = { fg = c.green },
		-- a number constant: 234, 0xff
		Number = { fg = c.orange },
		-- a boolean constant: TRUE, false
		Boolean = { fg = c.orange },
		-- a floating point constant: 2.3e10
		Float = { fg = c.orange },

		-- any variable name
		Identifier = { fg = c.cerulean },
		-- function name (also: methods for classes)
		Function = { fg = c.blue },

		-- any statement
		Statement = { fg = c.violet },
		-- if, then, else, endif, switch, etc.
		Operator = { fg = c.turquoise },
		-- any other keyword
		Keyword = { fg = c.violet },
		-- try, catch, throw
		Exception = { fg = c.red },

		-- PreProc		generic Preprocessor
		PreProc = { fg = c.gold },
		-- Include		preprocessor #include
		Include = { fg = c.gold },
		-- preprocessor #define
		Define = { fg = c.sepia },
		-- same as Define
		Macro = { fg = c.sepia },
		-- preprocessor #if, #else, #endif, etc.
		PreCondit = { fg = c.violet },

		-- Type		int, long, char, etc.
		Type = { fg = c.gold },
		-- static, register, volatile, etc.
		StorageClass = { fg = c.gold },
		-- struct, union, enum, etc.
		Structure = { fg = c.cerulean },
		-- a typedef
		Typedef = { fg = c.gold },

		-- any special symbol
		Special = { fg = c.rose },
		-- special character in a constant
		SpecialChar = { link = "Special" },
		-- you can use CTRL-] on this
		Tag = { fg = c.blue },
		-- character that needs attention
		Delimiter = { fg = c.turquoise },
		-- special things inside a comment
		SpecialComment = { link = "Special" },
		-- debugging statements
		Debug = { link = "Special" },

		-- text that stands out, HTML links
		Underlined = { fg = c.turquoise, underline = true },
		-- any erroneous construct
		Error = { fg = c.red },
		-- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
		Todo = { fg = c.bg, bg = c.vermilion, bold = true },

		-- added line in a diff
		Added = { fg = c.green },
		-- changed line in a diff
		Changed = { fg = c.orange },
		-- removed line in a diff
		Removed = { fg = c.red },
	}
end

return M
