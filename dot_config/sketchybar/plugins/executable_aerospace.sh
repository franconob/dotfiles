#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh
#
source "$CONFIG_DIR/colors.sh" # Loads all defined colors

if [ "$SENDER" = "aerospace_workspace_change" ] || [ "$SENDER" = "front_app_switched" ]; then
    CURRENT_WORKSPACE=$(/opt/homebrew/bin/aerospace list-workspaces --focused 2>/dev/null)

    if [ -z "$CURRENT_WORKSPACE" ]; then
      CURRENT_WORKSPACE="1"
    fi

    SELECTED_WORKSPACE="space.$CURRENT_WORKSPACE"

    if [ "$SELECTED_WORKSPACE" = "$NAME" ]; then
      sketchybar --set $NAME background.drawing=on \
                             background.color=$ACCENT_COLOR \
                             label.color=$BAR_COLOR \
                             icon.color=$BAR_COLOR
    else
        sketchybar --set $NAME background.drawing=off \
                               label.color=$ACCENT_COLOR \
                               icon.color=$ACCENT_COLOR

    fi
fi
