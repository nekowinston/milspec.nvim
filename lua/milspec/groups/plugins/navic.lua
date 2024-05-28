local M = {}

--- @param o MilspecOptions
--- @param c MilspecColors
--- @return table<string, vim.api.keyset.highlight>
M.get = function(o, c)
	return {
		NavicIconsArray = { link = "Type" },
		NavicIconsBoolean = { link = "Boolean" },
		NavicIconsClass = { link = "Type" },
		NavicIconsConstant = { link = "Constant" },
		NavicIconsConstructor = { link = "Function" },
		NavicIconsEnum = { link = "Structure" },
		NavicIconsEnumMember = { link = "Structure" },
		NavicIconsEvent = { link = "Function" },
		NavicIconsField = { link = "Identifier" },
		NavicIconsFile = { link = "Normal" },
		NavicIconsFunction = { link = "Function" },
		NavicIconsInterface = { link = "Type" },
		NavicIconsKey = { link = "Keyword" },
		NavicIconsMethod = { link = "Function" },
		NavicIconsModule = { link = "Type" },
		NavicIconsNamespace = { link = "Type" },
		NavicIconsNull = { link = "Constant" },
		NavicIconsNumber = { link = "Number" },
		NavicIconsObject = { link = "Type" },
		NavicIconsOperator = { link = "Operator" },
		NavicIconsPackage = { link = "Type" },
		NavicIconsProperty = { link = "Identifier" },
		NavicIconsString = { link = "String" },
		NavicIconsStruct = { link = "Structure" },
		NavicIconsTypeParameter = { link = "Type" },
		NavicIconsVariable = { link = "Identifier" },
		NavicSeparator = { link = "Delimiter" },
		NavicText = { link = "Normal" },
	}
end

return M
