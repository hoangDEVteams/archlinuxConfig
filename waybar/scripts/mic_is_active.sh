#!/usr/bin/env bash
set -euo pipefail

# Cần pactl (pipewire-pulse). Không có thì ẩn module.
if ! command -v pactl >/dev/null 2>&1; then
  exit 1
fi

# Không có ứng dụng dùng mic -> ẩn module (exit 1)
active=$(pactl list short source-outputs | wc -l | tr -d ' ')
if [[ "${active}" -eq 0 ]]; then
  exit 1
fi

# Trạng thái mute của nguồn mặc định (ưu tiên wpctl, fallback pactl)
muted="no"
if command -v wpctl >/dev/null 2>&1; then
  if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null | grep -q 'MUTED'; then
    muted="yes"
  fi
else
  if pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | grep -qi yes; then
    muted="yes"
  fi
fi

# Icon & class
icon=""   # mic
cls="active"
if [[ "$muted" == "yes" ]]; then
  icon="" # mic-slash (cần Nerd Font/FA; nếu không có font vẫn hiện ô vuông)
  cls="muted"
fi

# Tooltip: liệt kê app đang dùng mic
apps=$(pactl list source-outputs | awk -F': ' '/application.name/ {print $2}' | sort -u | paste -sd ', ' -)
tooltip=${apps:-"Microphone is in use"}

printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "$icon" "$tooltip" "$cls"
