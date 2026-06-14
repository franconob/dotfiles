#!/bin/bash

sketchybar --add event ai_status_change

sketchybar --add item ai_status left \
           --set ai_status icon="􀸙" \
                          label="AI idle" \
                          icon.color=$ACCENT_COLOR \
                          label.color=$ACCENT_COLOR \
                          update_freq=30 \
                          script="$PLUGIN_DIR/ai_status.sh" \
           --subscribe ai_status ai_status_change
