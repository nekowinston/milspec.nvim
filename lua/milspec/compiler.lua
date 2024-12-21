local M = {}

-- fallbacks for renamed names
---@diagnostic disable-next-line: undefined-global
local bit = bit or bit32
local uv = vim.uv or vim.loop

M.path_sep = vim.fn.has("unix") and "/" or "\\"
M.cache_dir = vim.fn.stdpath("cache") .. M.path_sep .. "milspec.nvim"

-- Dump a table to a one-line lua string representation of it.
---@param table any
---@return string
M.dump = function(table)
	return vim.inspect(table, { newline = "", indent = "" })
end

-- Generates a unique number hash from either strings or tables (by `dump`ing them first).
-- Uses the djb2 hashing algorithm
---@param input string
---@return number
M.hash = function(input)
	local hash = 5381
	for i = 1, #input do
		hash = bit.lshift(hash, 5) + hash + string.byte(input, i)
	end
	return hash
end

-- Get the filepath for the cachefile, depending on the options specified.
-- This allows us to take the shortcut of:
--
-- hash matches       -> load <cachedir>/<hash>-<variant>
-- hash doesn't match -> compile to <cachedir>/<hash>-variant
--
-- Since the hash is encoded in the filename there's no need to spend more time on IO.
---@param options      MilspecOptions
---@param variant_name MilspecVariant
---@return string
local function get_cache_fp(options, variant_name)
	--   2: remove the prefix of `@`
	-- -25: (length of "lua/milspec/compiler.lua" + 1) * -1
	local plugin_path = debug.getinfo(1).source:sub(2, -25)

	-- get the last modified time for the git index, returning -1 when not found
	local git_index = plugin_path .. ".git" .. M.path_sep .. "index"
	local ftime = vim.fn.getftime(git_index)

	-- if we have a git ftime, use it, otherwise assume that the plugin path is
	-- unique (such as being stored in /nix/store/<hash>-<name>)
	local state = ftime ~= -1 and tostring(ftime) or plugin_path

	-- hash for both the options + plugin state
	local hash = M.hash(M.dump(options) .. state)

	return M.cache_dir .. M.path_sep .. tostring(hash) .. "-" .. variant_name
end

-- Compiles both variants and caches them in the `M.cache_dir`
---@param options          MilspecOptions
---@param immediately_load MilspecVariant? when specified, this variant is loaded while compiling.
---@return nil
M.compile = function(options, immediately_load)
	if vim.fn.isdirectory(M.cache_dir) == 0 then
		vim.fn.mkdir(M.cache_dir, "p")
	end

	for _, variant_name in pairs({ "dark", "light" }) do
		local variant = require("milspec.colors").get_variant(variant_name)

		-- this should collect all file names in `./highlights/*.lua`
		local def_files = { "editor", "syntax" }
		-- collect all definition files
		--- @type table<string, vim.api.keyset.highlight>
		local highlights = {}
		for _, def in pairs(def_files) do
			highlights =
				vim.tbl_extend("force", highlights, require("milspec.highlights." .. def).get(options, variant))
		end
		-- and enabled plugins
		for plugin in pairs(options.plugins) do
			highlights = vim.tbl_extend(
				"force",
				highlights,
				require("milspec.highlights.plugins." .. plugin).get(options, variant)
			)
		end

		-- this should collect all file names in `./globals/*.lua`
		local global_files = { "terminal" }
		-- collect all vim.g globals
		local globals = {}
		for _, global in pairs(global_files) do
			globals = vim.tbl_extend("force", globals, require("milspec.globals." .. global).get(options, variant))
		end

		local cmds = ""
		-- generate vim.api.nvim_set_hl calls
		for name, val in pairs(highlights) do
			cmds = cmds .. string.format('  h(0, "%s", %s)\n', name, M.dump(val))
		end
		-- generate `vim.g[name] = val` calls
		for name, val in pairs(globals) do
			cmds = cmds .. string.format('  vim.g["%s"] = %s\n', name, M.dump(val))
		end

		local compiled = string.format(
			[[
return string.dump(function()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.api.nvim_command("syntax reset")
  end
  vim.opt.termguicolors = true
  h = vim.api.nvim_set_hl
%s
  vim.g.colors_name = "milspec"
end, true)
]],
			cmds
		)

		local chunked, err = loadstring(compiled)()
		if not chunked then
			vim.print("Failed to parse user options; here is the error that was caught:\n" .. err)
			return
		end

		-- instantly execute the loaded function when asked for
		if variant_name == immediately_load then
			load(chunked)()
		end

		local fp = get_cache_fp(options, variant_name)
		local fd = assert(uv.fs_open(fp, "w", 438), "Permission denied while writing milspec.nvim cache to " .. fp)

		uv.fs_write(fd, chunked)
		uv.fs_close(fd)
	end
end

-- Loads the specified variant, compiling it when necessary.
---@param options      MilspecOptions
---@param variant_name MilspecVariant
---@return nil
M.load = function(options, variant_name)
	local fp = get_cache_fp(options, variant_name)
	local apply_cache = loadfile(fp)

	if not apply_cache then
		-- specifying the arg variant_name to immediately load it after compiling
		M.compile(options, variant_name)
		return
	end

	apply_cache()
end

return M
