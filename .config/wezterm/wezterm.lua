-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Default shell
config.default_prog = { "zsh" }

-- Font & Colors
config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte
config.font = wezterm.font_with_fallback({
	"Cascadia Code NF",
	"Hiragino Maru Gothic ProN",
})
config.font_size = 18
-- Window
config.hide_tab_bar_if_only_one_tab = true
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.integrated_title_button_style = "MacOsNative"
config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 16.0,
}
-- Don't resize window when changing font size
config.adjust_window_size_when_changing_font_size = false

config.keys = {
	-- Use Cmd+Shift+P to activate command pallete (default Ctrl+Shift+P)
	{
		key = "p",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivateCommandPalette,
	},
}

-- and finally, return the configuration to wezterm
return config
