local M = {}

--- @param o MilspecOptions
--- @param c MilspecColors
--- @return table<string, vim.api.keyset.highlight>
M.get = function(o, c)
	local bg = o.transparent_background and "NONE" or c.bg

	return {
		NeoGitDiffAdd = { fg = c.green, bg = c.bg },
		NeoGitDiffDelete = { fg = c.red, bg = c.bg },
		NeoGitDiffContext = { fg = c.fg, bg = c.bg },

		-- TODO: shading utils removing the link and shading it against bg
		NeoGitDiffAddHighlight = { link = "NeoGitDiffAdd" },
		NeoGitDiffDeleteHighlight = { link = "NeoGitDiffDelete" },
		NeoGitDiffContextHighlight = { link = "NeoGitDiffContext" },

		NeogitHunkHeaderHighlight = { fg = c.fgGray, bg = c.bgGray },
		NeogitHunkHeaderCursor = { fg = c.fg, bg = c.bgGray },
	}
end

return M
