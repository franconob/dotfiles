#!/bin/bash

state_dir="${TMPDIR:-/tmp}"
ws_cache="$state_dir/sketchybar_aerospace_focused_workspace"
mode_cache="$state_dir/sketchybar_aerospace_mode"

focused_workspace=$(/opt/homebrew/bin/aerospace list-workspaces --focused 2>/dev/null)
if [ -n "$focused_workspace" ]; then
  previous_workspace=""
  [ -r "$ws_cache" ] && previous_workspace=$(/bin/cat "$ws_cache")

  if [ "$focused_workspace" != "$previous_workspace" ] || [ "$SENDER" = "system_woke" ]; then
    printf '%s' "$focused_workspace" > "$ws_cache"
    /opt/homebrew/bin/sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE="$focused_workspace"
  fi
fi

current_mode=$(/opt/homebrew/bin/aerospace list-modes --current 2>/dev/null)
if [ -n "$current_mode" ]; then
  previous_mode=""
  [ -r "$mode_cache" ] && previous_mode=$(/bin/cat "$mode_cache")

  if [ "$current_mode" != "$previous_mode" ] || [ "$SENDER" = "system_woke" ]; then
    printf '%s' "$current_mode" > "$mode_cache"
    /opt/homebrew/bin/sketchybar --trigger aerospace_mode_change
  fi
fi

if [ "$SENDER" = "system_woke" ]; then
  focused_app=$(/opt/homebrew/bin/aerospace list-windows --focused 2>/dev/null | /usr/bin/awk -F ' \| ' '{ print $2 }')
  if [ -n "$focused_app" ]; then
    /opt/homebrew/bin/sketchybar --trigger front_app_switched INFO="$focused_app"
  fi
  /opt/homebrew/bin/sketchybar --trigger ai_status_change
fi
