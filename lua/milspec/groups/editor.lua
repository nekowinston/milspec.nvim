local M = {}

--- @param o MilspecOptions
--- @param c MilspecColors
--- @return table<string, vim.api.keyset.highlight>
function M.get(o, c)
	local bg = o.transparent_background and "NONE" or c.bg

	return {
		Normal = { fg = c.fg, bg = bg },
		NormalFloat = { bg = "NONE" },
		Cursor = { fg = c.bg, bg = c.fg },
		Visual = { bg = c.bgGray },

		MatchParen = { bg = c.bgGray },

		FloatShadow = { bg = c.bg, blend = 80 },
		FloatShadowThrough = { bg = c.bg, blend = 100 },

		Search = { fg = c.bg, bg = c.indigo },
		IncSearch = { fg = c.bg, bg = c.indigo },
		CurSearch = { fg = c.bg, bg = c.vermilion },

		Pmenu = { fg = c.fg, bg = c.bg },
		PmenuExtra = { fg = c.fg, bg = c.bg },
		PmenuSel = { fg = c.fg, bg = c.bgGray },
		PmenuThumb = { bg = c.bgGray },

		LineNr = { fg = c.gray },
		CursorLine = { bg = c.bgGray },
		CursorColumn = { link = "CursorLine" },
		ColorColumn = { bg = c.gray },
		SignColumn = { fg = c.gray },
		FoldColumn = { link = "Folded" },
		Folded = { fg = c.gray },
		Conceal = { fg = c.bgGray },

		StatusLine = { fg = c.fgGray, bg = bg },
		StatusLineNC = { link = "StatusLine" },
		WinBar = { fg = c.fgGray, bg = bg },
		WinBarNC = { link = "WinBar" },
		WinSeparator = { fg = c.bgGray },

		NonText = { fg = c.bgGray },
		SpecialKey = { link = "NonText" },
		EndOfBuffer = { fg = o.show_eob and c.bgGray or c.bg },

		Directory = { fg = c.turquoise },

		DiffAdd = { fg = c.bg, bg = c.green },
		DiffChange = { fg = c.bg, bg = c.gold },
		DiffDelete = { fg = c.bg, bg = c.red },
		DiffText = { fg = c.bg, bg = c.blue },

		SpellRare = { fg = c.turquoise },
		SpellCap = { fg = c.gold, undercurl = true },
		SpellBad = { fg = c.red },
		SpellLocal = { fg = c.green },

		DiagnosticOk = { fg = c.green },
		DiagnosticInfo = { fg = c.turquoise },
		DiagnosticHint = { fg = c.turquoise },
		DiagnosticWarn = { fg = c.orange },
		DiagnosticDeprecated = { fg = c.orange },
		DiagnosticError = { fg = c.red },
		DiagnosticUnderlineInfo = { sp = c.turquoise, underline = true },
		DiagnosticUnderlineHint = { sp = c.turquoise, underline = true },
		DiagnosticUnderlineWarn = { sp = c.orange, underline = true },
		DiagnosticUnderlineError = { sp = c.red, underline = true },
		DiagnosticUnderlineOk = { sp = c.green, underline = true },

		Title = { fg = c.fg },
		Question = { fg = c.turquoise },
		ModeMsg = { fg = c.violet },
		MoreMsg = { fg = c.turquoise },
		QuickFixLine = { fg = c.turquoise },
		WarningMsg = { fg = c.orange },
		ErrorMsg = { fg = c.red },

		NvimInternalError = { fg = c.bg, bg = c.red },

		RedrawDebugClear = { bg = c.gold },
		RedrawDebugComposed = { bg = c.green },
		RedrawDebugRecompose = { bg = c.red },
	}
end

return M
