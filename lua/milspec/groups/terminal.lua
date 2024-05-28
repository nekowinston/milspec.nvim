local M = {}

--- @param o MilspecOptions
--- @param c MilspecColors
--- @return nil
function M.apply(o, c)
	vim.g.terminal_color_0 = c.bg
	vim.g.terminal_color_8 = c.gray

	vim.g.terminal_color_1 = c.red
	vim.g.terminal_color_9 = c.vermilion

	vim.g.terminal_color_2 = c.green
	vim.g.terminal_color_10 = c.forest

	vim.g.terminal_color_3 = c.gold
	vim.g.terminal_color_11 = c.sepia

	vim.g.terminal_color_4 = c.blue
	vim.g.terminal_color_12 = c.cerulean

	vim.g.terminal_color_5 = c.rose
	vim.g.terminal_color_13 = c.violet

	vim.g.terminal_color_6 = c.cerulean
	vim.g.terminal_color_14 = c.turquoise

	vim.g.terminal_color_7 = c.fg
	vim.g.terminal_color_15 = c.gray
end

return M
