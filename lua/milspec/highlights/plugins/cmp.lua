local M = {}

--- @param o MilspecOptions
--- @param c MilspecColors
--- @return table<string, vim.api.keyset.highlight>
M.get = function(o, c)
	return {
		CmpItemAbbr = { link = "Normal" },
		CmpItemAbbrDeprecated = { link = "Normal" },
		CmpItemAbbrMatch = { fg = c.indigo },
		CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
		CmpItemKind = { link = "Normal" },
		CmpItemMenu = { fg = c.gray },

		CmpItemKindClass = { link = "Type" },
		CmpItemKindColor = { link = "Color" },
		CmpItemKindConstant = { link = "Constant" },
		CmpItemKindConstructor = { link = "Function" },
		CmpItemKindEnum = { link = "Structure" },
		CmpItemKindEnumMember = { link = "Structure" },
		CmpItemKindEvent = { link = "Function" },
		CmpItemKindField = { link = "Identifier" },
		CmpItemKindFile = { link = "Special" },
		CmpItemKindFolder = { link = "Special" },
		CmpItemKindFunction = { link = "Function" },
		CmpItemKindInterface = { link = "Type" },
		CmpItemKindKeyword = { link = "Keyword" },
		CmpItemKindMethod = { link = "Function" },
		CmpItemKindModule = { link = "Type" },
		CmpItemKindOperator = { link = "Operator" },
		CmpItemKindProperty = { link = "Identifier" },
		CmpItemKindReference = { link = "Special" },
		CmpItemKindSnippet = { link = "Special" },
		CmpItemKindStruct = { link = "Structure" },
		CmpItemKindText = { link = "Normal" },
		CmpItemKindTypeParameter = { fg = c.vermilion },
		CmpItemKindUnit = { link = "Type" },
		CmpItemKindValue = { link = "Number" },
		CmpItemKindVariable = { link = "Identifier" },
	}
end

return M
