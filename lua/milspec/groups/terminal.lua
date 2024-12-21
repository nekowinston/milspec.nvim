local M = {}

--- @param o MilspecOptions
--- @param c MilspecColors
--- @return table<string, string>
function M.get(o, c)
	return {
		terminal_color_0 = c.bg,
		terminal_color_8 = c.gray,

		terminal_color_1 = c.red,
		terminal_color_9 = c.vermilion,

		terminal_color_2 = c.green,
		terminal_color_10 = c.forest,

		terminal_color_3 = c.gold,
		terminal_color_11 = c.sepia,

		terminal_color_4 = c.blue,
		terminal_color_12 = c.cerulean,

		terminal_color_5 = c.rose,
		terminal_color_13 = c.violet,

		terminal_color_6 = c.cerulean,
		terminal_color_14 = c.turquoise,

		terminal_color_7 = c.fg,
		terminal_color_15 = c.gray,
	}
end

return M
