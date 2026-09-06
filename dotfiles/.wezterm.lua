local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.audible_bell = "Disabled"

-- config.font = wezterm.font_with_fallback({
-- 	"Hack Nerd Font",
-- 	"Cascadia Mono",
-- })
config.font_size = 14

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

-- config.color_scheme = "nord"

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

config.window_padding = {
	left = 6,
	right = 6,
	top = 4,
	bottom = 6,
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe", "-NoLogo" }
end

config.keys = {
	{ key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
}

return config
