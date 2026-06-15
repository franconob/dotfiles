local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 15

config.default_prog = { "/bin/zsh", "-l" }
config.window_close_confirmation = "NeverPrompt"
config.automatically_reload_config = true

config.front_end = "WebGpu"
config.max_fps = 120
config.animation_fps = 120

config.scrollback_lines = 10000

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.window_decorations = "TITLE | RESIZE"
config.window_padding = {
  left = 6,
  right = 6,
  top = 4,
  bottom = 2,
}
config.window_background_opacity = 0.97
config.macos_window_background_blur = 14

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
  { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
  { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "&", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "H", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 4 }) },
  { key = "J", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 4 }) },
  { key = "K", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 4 }) },
  { key = "L", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 4 }) },
  { key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
  { key = "f", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
  { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES|TABS" }) },
  { key = "s", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|DOMAINS" }) },
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

-- my coolnight colorscheme:
config.colors = {
  foreground = "#CBE0F0",
  background = "#011423",
  cursor_bg = "#47FF9C",
  cursor_border = "#47FF9C",
  cursor_fg = "#011423",
  selection_bg = "#033259",
  selection_fg = "#CBE0F0",
  ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
  brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

wezterm.on("update-right-status", function(window, pane)
  local cwd_uri = pane:get_current_working_dir()
  local cwd = "~"
  if cwd_uri then
    local path = cwd_uri.file_path or cwd_uri.path or ""
    cwd = path:gsub(os.getenv("HOME"), "~")
  end

  window:set_right_status(wezterm.format({
    { Foreground = { Color = "#2CF9ED" } },
    { Text = " " .. window:active_workspace() .. " " },
    { Foreground = { Color = "#CBE0F0" } },
    { Text = cwd .. " " },
  }))
end)

return config
