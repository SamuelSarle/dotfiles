local wezterm = require("wezterm")
local config = {
	font = wezterm.font_with_fallback({
		{
			family = "FiraCode Nerd Font",
			weight = 600,
			harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
		},
		"devicons",
		"Noto Color Emoji",
	}),
	font_size = 13.0,
	adjust_window_size_when_changing_font_size = false,
	-- window_background_opacity = 0.75,
	-- macos_window_background_blur = 40,
	scrollback_lines = 50000,
	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	window_decorations = "RESIZE | INTEGRATED_BUTTONS",
	keys = {
		-- doesn't work:
		{ key = "UpArrow", mods = "SHIFT", action = wezterm.action.ScrollToPrompt(-1) },
		{ key = "]", mods = "CMD", action = wezterm.action.SplitPane({ direction = "Right" }) },
		{ key = "[", mods = "CMD", action = wezterm.action.SplitPane({ direction = "Down" }) },
		{ key = "z", mods = "CMD", action = wezterm.action.TogglePaneZoomState },
		{ key = "h", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "l", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "k", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "j", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Down") },
	},
	initial_cols = 100,
	initial_rows = 25,
	audible_bell = "Disabled",
	check_for_updates = false,
	-- default_cursor_style = "SteadyBlock",
	default_cursor_style = "BlinkingBlock",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 750,
	color_schemes = {
		["Modus-Vivendi"] = {
			background = "#1E1E1E",
			foreground = "#F0F0F0",
			tab_bar = {
				active_tab = {
					bg_color = "#1E1E1E",
					fg_color = "#FFFFFF",
					intensity = "Normal",
				},
			},
		},
	},
}

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Modus-Vivendi"
	else
		return "Modus-Operandi"
	end
end

wezterm.on("window-config-reloaded", function(window)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

return config
