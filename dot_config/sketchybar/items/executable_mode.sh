#!/bin/bash

sketchybar --add event aerospace_mode_change

sketchybar --add item aerospace_mode left \
           --set aerospace_mode icon="􀆔" \
                                label="MAIN" \
                                background.color=$ITEM_BG_COLOR \
                                icon.color=$ACCENT_COLOR \
                                label.color=$ACCENT_COLOR \
                                script="$PLUGIN_DIR/aerospace_mode.sh" \
           --subscribe aerospace_mode aerospace_mode_change
