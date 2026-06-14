#!/bin/bash

CONFIG_ROOT="${CONFIG_DIR:-$HOME/.config/sketchybar}"
if [ -r "$CONFIG_ROOT/colors.sh" ]; then
  # shellcheck disable=SC1090
  source "$CONFIG_ROOT/colors.sh"
fi

: "${BAR_COLOR:=0xff001f30}"
: "${ACCENT_COLOR:=0xff2cf9ed}"

state_dir="$HOME/.cache/ai-status"
claude_state="$state_dir/claude.state"
claude_running=$(/bin/ps -Ao comm= | /usr/bin/awk 'tolower($0) == "claude" { found = 1 } END { print found ? "yes" : "no" }')
opencode_running=$(/bin/ps -Ao comm= | /usr/bin/awk 'tolower($0) == "opencode" { found = 1 } END { print found ? "yes" : "no" }')

if [ "$claude_running" != "yes" ] && [ "$opencode_running" != "yes" ]; then
  sketchybar --set "$NAME" label="AI idle" icon.color=$ACCENT_COLOR label.color=$ACCENT_COLOR background.drawing=off
  exit 0
fi

if [ -r "$claude_state" ]; then
  claude_status=$(/usr/bin/awk -F= '/^status=/{print $2}' "$claude_state")
  if [ "$claude_status" = "thinking" ] && [ "$claude_running" = "yes" ]; then
    sketchybar --set "$NAME" label="CL thinking" background.drawing=on background.color=$ACCENT_COLOR icon.color=$BAR_COLOR label.color=$BAR_COLOR
    exit 0
  fi
  if [ "$claude_status" = "waiting" ] && [ "$claude_running" = "yes" ]; then
    sketchybar --set "$NAME" label="CL waiting" background.drawing=off icon.color=$ACCENT_COLOR label.color=$ACCENT_COLOR
    exit 0
  fi
fi

rows=$(/bin/ps -Ao pcpu=,stat=,command= | /usr/bin/awk '
  {
    proc = tolower($3)
    if (proc == "opencode" || proc == "claude") {
      print $0
    }
  }
')

if [ "$opencode_running" = "yes" ] && [ "$claude_running" = "yes" ]; then
  tool="AI"
elif [ "$opencode_running" = "yes" ]; then
  tool="OC"
else
  tool="CL"
fi

status="waiting"
if echo "$rows" | /usr/bin/awk '{ if ($1 + 0 >= 8) { found = 1 } } END { exit found ? 0 : 1 }'; then
  status="thinking"
elif echo "$rows" | /usr/bin/awk '{ if ($2 ~ /R/) { found = 1 } } END { exit found ? 0 : 1 }'; then
  status="thinking"
fi

if [ "$status" = "thinking" ]; then
  sketchybar --set "$NAME" label="$tool busy" background.drawing=on background.color=$ACCENT_COLOR icon.color=$BAR_COLOR label.color=$BAR_COLOR
else
  sketchybar --set "$NAME" label="$tool waiting" background.drawing=off icon.color=$ACCENT_COLOR label.color=$ACCENT_COLOR
fi
