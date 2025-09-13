#!/usr/bin/env bash
# mic_is_active.sh — Show icon ONLY when a program is using the microphone.
# Waybar: use with "return-type": "json".
# Logic: if there is at least one source-output (recording stream), print JSON; else exit 1.
set -euo pipefail

if ! command -v pactl >/dev/null 2>&1; then
  # No pactl => cannot check reliably -> hide
  exit 1
fi

# Count active mic recording streams
count="$(pactl list short source-outputs 2>/dev/null | wc -l | tr -d ' ')"
if [ "${count:-0}" -gt 0 ]; then
  # FontAwesome mic icon: \uf130 ()
  printf '{"text":"","tooltip":"Microphone is in use (%s stream%s)","class":"active"}\n' "$count" "$( [ "$count" -gt 1 ] && echo s || echo )"
  exit 0
fi

# Inactive => no output, non-zero exit -> Waybar hides the module
exit 1
