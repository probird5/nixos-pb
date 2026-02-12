#!/usr/bin/env bash
# MangoWC autostart script

WALLPAPER_DIR="$HOME/Pictures/backgrounds"

# Start swww daemon if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
fi

sleep 3

# Set random wallpaper
RANDOM_WALLPAPER=$(find -L "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | shuf -n 1)
if [ -n "$RANDOM_WALLPAPER" ]; then
    swww img "$RANDOM_WALLPAPER" --transition-type wipe --transition-angle 30 --transition-fps 255 --transition-duration 2
fi
