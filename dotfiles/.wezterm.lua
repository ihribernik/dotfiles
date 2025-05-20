local wezterm = require("wezterm")

local config = wezterm.config_builder()

function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return 'Dark'
end


function get_color_scheme()
	local appearance = get_appearance()
	local color_scheme = 'Poimandres'

	if not appearance:find('Dark') then
		color_scheme = 'Builtin Solarized Light'
	end

	return color_scheme
end

config.default_prog = { "bash" }

config.audible_bell = "Disabled"
config.font_size = 12
config.color_scheme = get_color_scheme()
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.keys = { { key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) } }

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh" }
end

config.font = wezterm.font("JetBrainsMono Nerd Font", { italic = false})

return config