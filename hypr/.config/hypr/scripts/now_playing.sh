#!/bin/bash
# Lắng nghe sự thay đổi metadata liên tục
playerctl metadata --follow --format '{{title}}||{{artist}}||{{mpris:artUrl}}' | while read -r line; do
    title=$(echo "$line" | awk -F'||' '{print $1}')
    artist=$(echo "$line" | awk -F'||' '{print $2}')
    # Xóa tiền tố file:// để lấy đường dẫn thực tế của ảnh bìa
    art=$(echo "$line" | awk -F'||' '{print $3}' | sed 's|^file://||')

    if [[ -n "$title" ]]; then
        # Gửi thông báo. Dùng x-dunst-stack-tag để ghi đè popup cũ, tránh spam màn hình.
        notify-send -a "MusicPlayer" "$title" "$artist" -i "$art" -h string:x-dunst-stack-tag:music
    fi
done
