#!/usr/bin/env bash
# Change wallpaper on-demand with swww transition

WALLPAPER_DIR="$HOME/Pictures/backgrounds"

# Pick a random wallpaper (-L follows symlinks for nix store paths)
RANDOM_WALLPAPER=$(find -L "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | shuf -n 1)

# Apply with transition
swww img "$RANDOM_WALLPAPER" --transition-type wipe --transition-angle 30 --transition-fps 255 --transition-duration 2
