#!/bin/bash

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_PERCENT=$(
  ps -Ao pcpu= | awk -v cores="$CORE_COUNT" '
    { total += $1 }
    END { printf "%.0f\n", total / cores }
  '
)

sketchybar --set $NAME label="$CPU_PERCENT%"
