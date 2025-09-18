#!/usr/bin/env bash
set -euo pipefail
DIR="${1:-$HOME/Pictures/.wallpapers}"
if ! command -v zenity >/dev/null 2>&1; then
  notify-send "Wallpaper picker" "Thiếu zenity. Cài: sudo pacman -S zenity"; exit 1
fi
file=$(zenity --file-selection --title="Chọn hình nền"   --filename="$DIR/"   --file-filter="Hình ảnh | *.jpg *.jpeg *.png *.webp *.bmp" || true)
[ -n "${file:-}" ] || exit 0
if command -v swww >/dev/null 2>&1; then
  pgrep -x swww-daemon >/dev/null 2>&1 || swww init
  swww img "$file" --transition-type any --transition-duration 0.5 --resize crop
elif command -v hyprctl >/dev/null 2>&1; then
  hyprctl hyprpaper preload "$file" 2>/dev/null || true
  while read -r mon; do
    hyprctl hyprpaper wallpaper "$mon,$file" 2>/dev/null || true
  done < <(hyprctl monitors | awk '/Monitor /{print $2}')
else
  notify-send "Wallpaper picker" "Không tìm thấy swww hoặc hyprpaper"; exit 1
fi
notify-send "Wallpaper updated" "$(basename "$file)"
