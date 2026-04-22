#!/usr/bin/env bash

CFG="$HOME/.config/waybar/side.jsonc"
CSS="$HOME/.config/waybar/side.css"

if pgrep -f "waybar -c $CFG" >/dev/null; then
  pkill -f "waybar -c $CFG"
else
  waybar -c "$CFG" -s "$CSS" &
fi

