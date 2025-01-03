--- @type fun(variant: MilspecVariant?)
return function(variant)
	local c = require("milspec.colors").get_variant(variant)
	local o = require("milspec").options

	local bg = o.transparent_background and "NONE" or c.bg

	-- for better contrast on `lualine_b_diff_*` highlights
	local highlights = {
		LuaLineDiffAdd = { link = "Added" },
		LuaLineDiffChange = { link = "Changed" },
		LuaLineDiffDelete = { link = "Removed" },
	}

	for group, tables in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, tables)
	end

	return {
		normal = {
			a = { bg = c.blue, fg = c.bg, gui = "bold" },
			b = { bg = c.bgGray, fg = c.blue },
			c = { bg = bg, fg = c.fg },
		},
		insert = {
			a = { bg = c.green, fg = c.bg, gui = "bold" },
			b = { bg = c.bgGray, fg = c.green },
		},
		terminal = {
			a = { bg = c.green, fg = c.bg, gui = "bold" },
			b = { bg = c.bgGray, fg = c.green },
		},
		command = {
			a = { bg = c.gold, fg = c.bg, gui = "bold" },
			b = { bg = c.bgGray, fg = c.gold },
		},
		visual = {
			a = { bg = c.violet, fg = c.bg, gui = "bold" },
			b = { bg = c.bgGray, fg = c.violet },
		},
		replace = {
			a = { bg = c.orange, fg = c.bg, gui = "bold" },
			b = { bg = c.bgGray, fg = c.orange },
		},
		inactive = {
			a = { bg = bg, fg = c.blue },
			b = { bg = bg, fg = c.gray, gui = "bold" },
			c = { bg = bg, fg = c.gray },
		},
	}
end
