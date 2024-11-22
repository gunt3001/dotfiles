-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Default shell
config.default_prog = { 'pwsh' }

-- Font & Colors
config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte
config.font = wezterm.font 'Cascadia Code NF'
-- Window
config.hide_tab_bar_if_only_one_tab = false
config.window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  font = wezterm.font { family = 'Segoe UI Semibold', weight = 'Regular' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 10.0,
}
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- Don't resize window when changing font size
config.adjust_window_size_when_changing_font_size = false

-- Hotkeys
config.keys = {
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen
  }
}

-- and finally, return the configuration to wezterm
return config
