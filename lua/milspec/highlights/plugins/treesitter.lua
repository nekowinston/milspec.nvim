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

		-- ditto for Nix
		["@variable.member.nix"] = { link = "@property" },

		-- CXX
		["@type.builtin.c"] = { link = "Keyword" },

		["@markup.heading.1.markdown"] = { fg = c.red },
		["@markup.heading.2.markdown"] = { fg = c.orange },
		["@markup.heading.3.markdown"] = { fg = c.gold },
		["@markup.heading.4.markdown"] = { fg = c.green },
		["@markup.heading.5.markdown"] = { fg = c.violet },
		["@markup.heading.6.markdown"] = { fg = c.turquoise },

		["@decorator"] = { fg = c.orange },
	}
end

return M
