#!/bin/bash

mode=$(/opt/homebrew/bin/aerospace list-modes --current 2>/dev/null | tr '[:lower:]' '[:upper:]')

if [ -z "$mode" ]; then
  mode="MAIN"
fi

if [ "$mode" = "SERVICE" ]; then
  sketchybar --set "$NAME" label="$mode" background.drawing=on background.color=$ACCENT_COLOR icon.color=$BAR_COLOR label.color=$BAR_COLOR
else
  sketchybar --set "$NAME" label="$mode" background.drawing=off icon.color=$ACCENT_COLOR label.color=$ACCENT_COLOR
fi
