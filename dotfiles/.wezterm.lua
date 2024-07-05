-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_prog = { "bash" }
-- config.color_scheme = "One Dark (Gogh)"
config.audible_bell = "Disabled"
config.font_size = 12
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.85
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.keys = {
	{
		key = "v",
		mods = "CTRL",
		action = wezterm.action({ PasteFrom = "Clipboard" }),
	},
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- TODO: this can change in the future to pwsh or something
	config.default_prog = { "C:/Program Files/Git/bin/bash.exe -i -l" }
end

config.font = wezterm.font("JetBrainsMono Nerd Font", { italic = false })

return config
