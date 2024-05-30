local M = {}

--- @param o MilspecOptions
--- @param c MilspecColors
--- @return table<string, vim.api.keyset.highlight>
M.get = function(o, c)
	return {
		["@variable"] = { link = "Normal" },
		["@variable.parameter"] = { fg = c.vermilion },
		["@function.builtin"] = { link = "Function" },

		["@string.regexp"] = { link = "Special" },

		-- make TOML look like JSON/yaml
		tomlTable = { fg = c.gold },
		tomlDotInKey = { link = "Delimiter" },

		-- CXX
		["@type.builtin.c"] = { link = "Keyword" },
	}
end

return M
