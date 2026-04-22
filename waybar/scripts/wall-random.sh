#!/usr/bin/env bash
set -euo pipefail
DIR="${1:-$HOME/Pictures/.wallpapers}"
mapfile -t files < <(find "$DIR" -type f \
  \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.bmp' \) 2>/dev/null | sort)
if [ "${#files[@]}" -eq 0 ]; then
  notify-send "Random wallpaper" "Không tìm thấy ảnh trong $DIR"; exit 1
fi
idx=$(( RANDOM % ${#files[@]} ))
file="${files[$idx]}"
if command -v swww >/dev/null 2>&1; then
  pgrep -x swww-daemon >/dev/null 2>&1 || swww init
  swww img "$file" --transition-type any --transition-duration 0.5 --resize crop
elif command -v hyprctl >/dev/null 2>&1; then
  hyprctl hyprpaper preload "$file" 2>/dev/null || true
  while read -r mon; do
    hyprctl hyprpaper wallpaper "$mon,$file" 2>/dev/null || true
  done < <(hyprctl monitors | awk '/Monitor /{print $2}')
else
  notify-send "Random wallpaper" "Không tìm thấy swww hoặc hyprpaper"; exit 1
fi
notify-send "Wallpaper updated" "$(basename "$file)"
