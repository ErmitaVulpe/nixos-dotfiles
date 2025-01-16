local wezterm = require "wezterm"
local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.enable_wayland = false
-- config.font = wezterm.font "Fira Mono Nerd Font"
config.hide_tab_bar_if_only_one_tab = true
-- wp here
config.colors = {
    cursor_bg = "silver",
    foreground = "#E2DEFF",
}
config.text_background_opacity = 0.7
config.window_padding = {
    left = "5px",
    right = "5px",
    top = "5px",
    bottom = "5px",
}

return config
