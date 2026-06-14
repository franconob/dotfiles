#!/bin/bash

if [ "$SENDER" = "aerospace_workspace_change" ] || [ "$SENDER" = "front_app_switched" ]; then
  space=$(/opt/homebrew/bin/aerospace list-workspaces --focused 2>/dev/null)
  [ -z "$space" ] && exit 0

  apps=$(/opt/homebrew/bin/aerospace list-windows --workspace $space \
  | awk -F ' \\| ' '{ print $2 }' | sort -u)

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi

  sketchybar --set space.$space label="$icon_strip"
fi
