local M = {}

-- fallback
---@diagnostic disable-next-line: undefined-global
local bit = bit or bit32

M.path_sep = vim.fn.has("unix") and "/" or "\\"
M.cache_dir = vim.fn.stdpath("cache") .. M.path_sep .. "milspec.nvim"

---@param table any
---@return string
M.dump = function(table)
	return vim.inspect(table, { newline = "", indent = "" })
end

---@param options      MilspecOptions
---@param variant_name MilspecVariant
local function get_fp_for_opts(options, variant_name)
	local hash = M.hash(options)
	return M.cache_dir .. M.path_sep .. tostring(hash) .. "-" .. variant_name
end

---@param input string | table
---@return number
M.hash = function(input)
	if type(input) == "table" then
		input = M.dump(input)
	end

	local hash = 5381
	for i = 1, #input do
		hash = bit.lshift(hash, 5) + hash + string.byte(input, i)
	end
	return hash
end

---@param options          MilspecOptions
---@param immediately_load MilspecVariant?
M.compile = function(options, immediately_load)
	if vim.fn.isdirectory(M.cache_dir) == 0 then
		vim.fn.mkdir(M.cache_dir, "p")
	end

	for _, variant_name in pairs({ "dark", "light" }) do
		local variant = require("milspec.colors").get_variant(variant_name)

		local defs = {
			require("milspec.groups.editor").get(options, variant),
			require("milspec.groups.syntax").get(options, variant),
		}
		for plugin in pairs(options.plugins) do
			table.insert(defs, require("milspec.groups.plugins." .. plugin).get(options, variant))
		end

		--- @type table<string, vim.api.keyset.highlight>
		local highlights = vim.tbl_extend("keep", unpack(defs))

		local text = [[
return string.dump(function()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.api.nvim_command("syntax reset")
  end
  vim.opt.termguicolors = true
  h = vim.api.nvim_set_hl
    ]]

		for group, highlight in pairs(highlights) do
			text = text .. string.format('  h(0, "%s", %s)\n', group, M.dump(highlight))
		end

		-- there's only one file adding globals atm
		local globals = require("milspec.groups.terminal").get(options, variant)
		for name, value in pairs(globals) do
			text = text .. string.format('  vim.g["%s"] = %s\n', name, M.dump(value))
		end

		text = text .. [[
  vim.g.colors_name = "milspec"
end, true)
]]

		local chunked, err = loadstring(text)()
		local fp = get_fp_for_opts(options, variant_name)
		local file = assert(io.open(fp, "wb"), "Permission denied while writing milspec.nvim cache to " .. fp)

		if not chunked then
			vim.print("Failed to parse user options; here is the error that was caught:\n" .. err)
			return
		end

		-- instantly execute the loaded function
		if variant_name == immediately_load then
			load(chunked)()
		end

		file:write(chunked)
		file:close()
	end
end

---@param options      MilspecOptions
---@param variant_name MilspecVariant
M.load_compiled = function(options, variant_name)
	local fp = get_fp_for_opts(options, variant_name)
	local cached = loadfile(fp)

	if not cached then
		M.compile(options, variant_name)
		return
	end

	cached()
end

return M
