local M = {}

--- @param o MilspecOptions
--- @param c MilspecColors
--- @return table<string, vim.api.keyset.highlight>
M.get = function(o, c)
	return {
		RenderMarkdownH1 = { link = "@markup.heading.1.markdown" },
		RenderMarkdownH2 = { link = "@markup.heading.2.markdown" },
		RenderMarkdownH3 = { link = "@markup.heading.3.markdown" },
		RenderMarkdownH4 = { link = "@markup.heading.4.markdown" },
		RenderMarkdownH5 = { link = "@markup.heading.5.markdown" },
		RenderMarkdownH6 = { link = "@markup.heading.6.markdown" },
		RenderMarkdownH1Bg = { fg = c.core, bg = c.red },
		RenderMarkdownH2Bg = { fg = c.core, bg = c.orange },
		RenderMarkdownH3Bg = { fg = c.core, bg = c.gold },
		RenderMarkdownH4Bg = { fg = c.core, bg = c.green },
		RenderMarkdownH5Bg = { fg = c.core, bg = c.violet },
		RenderMarkdownH6Bg = { fg = c.core, bg = c.turquoise },
		RenderMarkdownCode = { bg = c.core },
	}
end

return M
