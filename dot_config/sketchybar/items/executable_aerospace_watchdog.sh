#!/bin/bash

sketchybar --add item aerospace_watchdog left \
           --set aerospace_watchdog drawing=off \
                                     updates=on \
                                     update_freq=3 \
                                     script="$PLUGIN_DIR/aerospace_watchdog.sh" \
           --subscribe aerospace_watchdog system_woke
