set -euo pipefail
if command -v rofi-wayland >/dev/null; then rofi_bin=rofi-wayland; else rofi_bin=rofi; fi

theme="${1:-}"
if [ -n "${theme}" ] && [ -f "${theme}" ]; then
 exec "$rofi_bin" -show drun -modi drun,run,window -show-icons -disable-history -theme "$theme"
else
exec "$rofi_bin" -show drun -modi drun,run,window -show-icons -disable-history
fi
