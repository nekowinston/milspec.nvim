local M = {}

--- @param o MilspecOptions
--- @param c MilspecColors
--- @return table<string, vim.api.keyset.highlight>
M.get = function(o, c)
	local optional_core = o.transparent_background and "NONE" or c.core

	return {
		NvimTreeFolderName = { fg = c.cerulean },
		NvimTreeFolderIcon = { fg = c.cerulean },
		NvimTreeIndentMarker = { fg = c.gray },
		NvimTreeOpenedFolderName = { link = "NvimTreeFolderName" },
		NvimTreeEmptyFolderName = { link = "NvimTreeFolderName" },
	}
end

return M
