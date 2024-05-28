local M = {}

--- @type fun(variant: MilspecVariant?): fun(): table<string, vim.api.keyset.highlight>
function M.get(variant)
	return function()
		local c = require("milspec.colors").get_variant(variant)
		local o = require("milspec").options

		local bg = o.transparent_background and "NONE" or c.core

		local active = {
			bg = c.bg,
			fg = c.fg,
		}
		local inactive = {
			bg = bg,
			fg = c.fg,
		}

		return {
			fill = { bg = bg },
			background = { bg = bg },

			tab = {
				fg = inactive.fg,
				bg = inactive.bg,
			},
			tab_selected = {
				fg = active.fg,
				bg = active.bg,
			},

			tab_separator = {
				fg = c.gray,
				bg = inactive.bg,
			},
			tab_separator_selected = {
				fg = c.gray,
				bg = active.bg,
			},

			tab_close = {
				fg = c.fgGray,
				bg = inactive.bg,
			},

			close_button = {
				fg = c.fgGray,
				bg = inactive.bg,
			},
			close_button_visible = {
				fg = c.fgGray,
				bg = inactive.bg,
			},
			close_button_selected = {
				fg = c.fg,
				bg = active.bg,
			},

			buffer = {
				fg = inactive.fg,
				bg = inactive.bg,
			},
			buffer_visible = {
				fg = inactive.fg,
				bg = inactive.bg,
			},
			buffer_selected = {
				fg = active.fg,
				bg = active.bg,
				bold = true,
				italic = true,
			},

			numbers = {
				fg = c.orange,
				bg = inactive.bg,
			},
			numbers_visible = {
				fg = c.orange,
				bg = inactive.bg,
			},
			numbers_selected = {
				fg = c.orange,
				bg = active.bg,
				bold = true,
				italic = true,
			},

			hint = {
				fg = c.turquoise,
				bg = inactive.bg,
			},
			hint_visible = {
				fg = c.turquoise,
				bg = inactive.bg,
			},
			hint_selected = {
				fg = c.turquoise,
				bg = inactive.bg,
				bold = true,
				italic = true,
			},

			hint_diagnostic = {
				fg = c.turquoise,
				bg = inactive.bg,
			},
			hint_diagnostic_visible = {
				fg = c.turquoise,
				bg = inactive.bg,
			},
			hint_diagnostic_selected = {
				fg = c.turquoise,
				bg = inactive.bg,
				bold = true,
				italic = true,
			},

			info = {
				fg = c.turquoise,
				bg = inactive.bg,
			},
			info_visible = {
				fg = c.turquoise,
				bg = inactive.bg,
			},
			info_selected = {
				fg = c.turquoise,
				bg = inactive.bg,
				bold = true,
				italic = true,
			},

			info_diagnostic = {
				fg = c.turquoise,
				bg = inactive.bg,
			},
			info_diagnostic_visible = {
				fg = c.turquoise,
				bg = inactive.bg,
			},
			info_diagnostic_selected = {
				fg = c.turquoise,
				bg = inactive.bg,
				bold = true,
				italic = true,
			},

			warning = {
				fg = c.orange,
				bg = inactive.bg,
			},
			warning_visible = {
				fg = c.orange,
				bg = inactive.bg,
			},
			warning_selected = {
				fg = c.orange,
				bg = active.bg,
				bold = true,
				italic = true,
			},

			warning_diagnostic = {
				fg = c.orange,
				bg = inactive.bg,
			},
			warning_diagnostic_visible = {
				fg = c.orange,
				bg = inactive.bg,
			},
			warning_diagnostic_selected = {
				fg = c.orange,
				bg = active.bg,
				bold = true,
				italic = true,
			},

			error = {
				fg = c.red,
				bg = active.bg,
			},
			error_visible = {
				fg = c.red,
				bg = active.bg,
			},
			error_selected = {
				fg = c.red,
				bg = inactive.bg,
				bold = true,
				italic = true,
			},

			error_diagnostic = {
				fg = c.red,
				bg = active.bg,
			},
			error_diagnostic_visible = {
				fg = c.red,
				bg = active.bg,
			},
			error_diagnostic_selected = {
				fg = c.red,
				bg = inactive.bg,
				bold = true,
				italic = true,
			},

			modified = {
				fg = c.green,
				bg = inactive.bg,
			},
			modified_visible = {
				fg = c.green,
				bg = inactive.bg,
			},
			modified_selected = {
				fg = c.green,
				bg = active.bg,
			},

			duplicate = {
				fg = inactive.fg,
				bg = inactive.bg,
			},
			duplicate_visible = {
				fg = inactive.fg,
				bg = inactive.bg,
			},
			duplicate_selected = {
				fg = active.fg,
				bg = active.bg,
				italic = true,
				bold = true,
			},

			separator = {
				fg = c.gray,
				bg = inactive.bg,
			},
			separator_visible = {
				fg = c.gray,
				bg = inactive.bg,
			},
			separator_selected = {
				fg = c.gray,
				bg = active.bg,
			},

			indicator_visible = {
				fg = c.rose,
				bg = inactive.bg,
			},
			indicator_selected = {
				fg = c.fg,
				bg = active.bg,
			},

			pick = {
				fg = c.red,
				bg = inactive.bg,
				bold = true,
				italic = true,
			},
			pick_visible = {
				fg = c.red,
				bg = inactive.bg,
				bold = true,
				italic = true,
			},
			pick_selected = {
				fg = c.red,
				bg = active.bg,
				bold = true,
				italic = true,
			},

			offset_separator = {
				fg = active.fg,
				bg = c.core,
			},
			trunc_marker = {
				fg = c.bgGray,
				bg = inactive.bg,
			},
		}
	end
end

return M
