local wezterm = require("wezterm")

local M = {}

--- @type table<"dark"|"light", MilspecColors>
local variants = {
	dark = {
		fg = "#ffffff",
		bg = "#1c2127",
		gray = "#c5cbd3",
		bgGray = "#404854",
		fgGray = "#d3d8de",
		core = "#111418",
		blue = "#8abbff",
		green = "#72ca9b",
		orange = "#fbb360",
		red = "#fa999c",
		vermilion = "#ff9980",
		rose = "#ff66a1",
		violet = "#d69fd6",
		indigo = "#bdadff",
		cerulean = "#68c1ee",
		turquoise = "#7ae1d8",
		forest = "#62d96b",
		lime = "#d4f17e",
		gold = "#fbd065",
		sepia = "#d0b090",
	},
	light = {
		fg = "#111418",
		bg = "#f6f7f9",
		gray = "#5f6b7c",
		bgGray = "#d3d8de",
		fgGray = "#404854",
		core = "#ffffff",
		blue = "#2d72d2",
		green = "#238551",
		orange = "#c87619",
		red = "#cd4246",
		vermilion = "#d33d17",
		rose = "#db2c6f",
		violet = "#9d3f9d",
		indigo = "#7961db",
		cerulean = "#147eb3",
		turquoise = "#00a396",
		forest = "#29a634",
		lime = "#8eb125",
		gold = "#d1980b",
		sepia = "#946638",
	},
}

--- @type fun(variant: MilspecVariant?): MilspecColors
function M.select(flavor)
	local c = variants[flavor]

	return {
		foreground = c.fg,
		background = c.bg,

		cursor_fg = c.bg,
		cursor_bg = c.fg,
		cursor_border = c.fg,

		selection_fg = c.fg,
		selection_bg = c.bgGray,

		scrollbar_thumb = c.gray,

		split = c.gray,

		ansi = { c.bg, c.red, c.green, c.orange, c.blue, c.rose, c.cerulean, c.fg },
		brights = { c.gray, c.vermilion, c.forest, c.sepia, c.cerulean, c.violet, c.turquoise, c.gray },

		-- nightbuild only
		compose_cursor = c.rose,

		tab_bar = {
			background = c.bg,
			active_tab = {
				bg_color = c.blue,
				fg_color = c.bg,
			},
			inactive_tab = {
				bg_color = c.bg,
				fg_color = c.fg,
			},
			inactive_tab_hover = {
				bg_color = c.bgGray,
				fg_color = c.fg,
			},
			new_tab = {
				bg_color = c.bgGray,
				fg_color = c.fg,
			},
			new_tab_hover = {
				bg_color = c.gray,
				fg_color = c.bg,
			},
			-- fancy tab bar
			inactive_tab_edge = c.gray,
		},

		visual_bell = c.gray,
	}
end

local function select_for_appearance(appearance, options)
	if appearance:find("Dark") then
		return options.dark
	else
		return options.light
	end
end

--- @type fun(t1: table, t2: table): table
local function tableMerge(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k] or false) == "table" then
				tableMerge(t1[k] or {}, t2[k] or {})
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
	return t1
end

--- @type fun(c: any, opts: { flavor: MilspecVariant, sync: boolean }): nil
function M.apply_to_config(config, opts)
	if not opts then
		opts = {}
	end
	local defaults = {
		flavor = "dark",
		sync = true,
	}
	opts = tableMerge(defaults, opts)

	if config.color_schemes == nil then
		config.color_schemes = {}
	end
	config.color_schemes["Milspec (dark)"] = M.select("dark")
	config.color_schemes["Milspec (light)"] = M.select("light")

	local variantName = opts.flavor == "dark" and "Milspec (dark)" or "Milspec (light)"

	if opts.sync then
		config.color_scheme = select_for_appearance(wezterm.gui.get_appearance(), {
			dark = "Milspec (dark)",
			light = "Milspec (light)",
		})
		config.command_palette_bg_color = select_for_appearance(wezterm.gui.get_appearance(), {
			dark = variants.dark.bgGray,
			light = variants.light.bgGray,
		})
		config.command_palette_fg_color = select_for_appearance(wezterm.gui.get_appearance(), {
			dark = variants.dark.fg,
			light = variants.light.fg,
		})
	else
		config.color_scheme = variantName
		config.command_palette_bg_color = variants[opts.flavor].bgGray
		config.command_palette_fg_color = variants[opts.flavor].fg
	end

	local window_frame = {
		active_titlebar_bg = variants[opts.flavor].bg,
		active_titlebar_fg = variants[opts.flavor].fg,
		inactive_titlebar_bg = variants[opts.flavor].bg,
		inactive_titlebar_fg = variants[opts.flavor].fg,
		button_fg = variants[opts.flavor].fg,
		button_bg = variants[opts.flavor].bg,
	}

	if config.window_frame == nil then
		config.window_frame = {}
	end
	config.window_frame = tableMerge(config.window_frame, window_frame)
end

return M
