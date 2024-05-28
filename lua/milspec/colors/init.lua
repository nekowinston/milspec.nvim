local M = {}

--- @type fun(variant: MilspecVariant?): MilspecColors
function M.get_variant(variant)
	if variant == nil then
		variant = vim.o.background
	end

	if variant == "light" then
		return require("milspec.colors.light")
	else
		return require("milspec.colors.dark")
	end
end

return M
