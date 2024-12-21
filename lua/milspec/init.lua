--- @class Milspec
local M = {}

--- @class MilspecOptions
local default_options = {
	--- Controls whether to show the end-of-buffer `~` characters
	--- @type boolean?
	show_eob = false,

	--- Controls whether to theme the terminal colors via `vim.g.terminal_color_0` through `vim.g.terminal_color_15`.
	--- @type boolean?
	term_colors = true,

	--- Controls whether to use a transparent background.
	--- @type boolean?
	transparent_background = false,

	--- Controls which plugins to support. All supported plugins are enabled by default.
	--- @class MilspecPlugins?
	plugins = {
		--- Whether to enable [`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp) support.
		--- @type boolean?
		cmp = true,

		--- Whether to enable [`navic`](https://github.com/SmiteshP/nvim-navic) support.
		--- @type boolean?
		navic = true,

		--- Whether to enable [`neogit`](https://github.com/NeogitOrg/neogit) support.
		--- @type boolean?
		neogit = true,

		--- Whether to enable [`nvim-tree.lua`](https://github.com/nvim-tree/nvim-tree.lua) support.
		--- @type boolean?
		nvim_tree = true,

		--- Whether to enable [`rainbow-delimiters.nvim`](https://github.com/hiphish/rainbow-delimiters.nvim) support.
		--- @type boolean?
		rainbow_delimiters = true,

		--- Whether to enable [`render-markdown.nvim`](https://github.com/MeanderingProgrammer/render-markdown.nvim) support.
		--- @type boolean?
		render_markdown = true,

		--- Whether to enable [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) support.
		--- @type boolean?
		treesitter = true,
	},
}

--- User options for Milspec.
--- @type MilspecOptions
M.options = default_options

--- @param options MilspecOptions
local function validate_options(options)
	vim.validate({
		show_eob = { options.show_eob, "boolean", true },
		term_colors = { options.term_colors, "boolean", true },
		transparent_background = { options.transparent_background, "boolean", true },
	})
	vim.validate({
		cmp = { options.plugins.cmp, "boolean", true },
		navic = { options.plugins.navic, "boolean", true },
		neogit = { options.plugins.neogit, "boolean", true },
		rainbow_delimiters = { options.plugins.rainbow_delimiters, "boolean", true },
		treesitter = { options.plugins.treesitter, "boolean", true },
	})
end

--- @type boolean Whether the setup function has been run.
local ran_setup = false

--- @type fun(variant: MilspecVariant?): nil
M.load = function(variant)
	if not ran_setup then
		M.setup()
	end

	require("milspec.compiler").load_compiled(M.options, variant or "dark")
end

--- @type fun(conf: MilspecOptions?): nil
M.setup = function(conf)
	ran_setup = true

	conf = conf or {}
	M.options = vim.tbl_deep_extend("keep", conf, default_options)

	validate_options(M.options)
end

return M
