#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpaper"

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Directory $WALLPAPER_DIR not found"
    exit 1
fi

PICKED=$(find "$WALLPAPER_DIR" -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' -o -name '*.webp' \) | shuf -n 1)

if [ -z "$PICKED" ]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

ln -sf "$PICKED" "$WALLPAPER_DIR/current.png"

hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$PICKED"

while read -r mon; do
    [ -n "$mon" ] || continue
    hyprctl hyprpaper wallpaper "$mon,$PICKED"
done < <(hyprctl monitors -j 2>/dev/null | jq -r '.[].name')

echo "Wallpaper set: $PICKED"
