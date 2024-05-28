local M = {}

--- @param o MilspecOptions
--- @param c MilspecColors
--- @return table<string, vim.api.keyset.highlight>
M.get = function(o, c)
	return {
		RainbowDelimiterRed = { fg = c.red },
		RainbowDelimiterYellow = { fg = c.gold },
		RainbowDelimiterBlue = { fg = c.blue },
		RainbowDelimiterOrange = { fg = c.orange },
		RainbowDelimiterGreen = { fg = c.green },
		RainbowDelimiterViolet = { fg = c.violet },
		RainbowDelimiterCyan = { fg = c.turquoise },
	}
end

return M
