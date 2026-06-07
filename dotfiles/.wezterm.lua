local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "bash" }
config.audible_bell = "Disabled"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14
config.window_background_opacity = 0.9

config.color_scheme = "iTerm2 Default"
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
-- config.default_domain = 'WSL:Ubuntu'

config.keys = {
	{ key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh" }
end

return config
