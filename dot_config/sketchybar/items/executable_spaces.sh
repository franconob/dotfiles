#!/bin/bash

sketchybar --add event aerospace_workspace_change

for sid in $(/opt/homebrew/bin/aerospace list-workspaces --all);
do
  sketchybar --add space space.$sid left                                 \
             --set space.$sid space=$sid                                 \
                              icon=$sid                                  \
                              label.font="sketchybar-app-font:Regular:16.0" \
                              label.padding_right=20                     \
                              label.y_offset=-1                          \
                              click_script="/opt/homebrew/bin/aerospace workspace $sid" \
                              script="$PLUGIN_DIR/aerospace.sh" \
             --subscribe space.$sid aerospace_workspace_change front_app_switched
done

sketchybar --add item space_separator left                             \
           --set space_separator icon="􀆊"                                \
                                 icon.color=$ACCENT_COLOR \
                                 icon.padding_left=4                   \
                                  label.drawing=off                     \
                                  background.drawing=off                \
                                  script="$PLUGIN_DIR/space_windows.sh" \
            --subscribe space_separator aerospace_workspace_change front_app_switched
