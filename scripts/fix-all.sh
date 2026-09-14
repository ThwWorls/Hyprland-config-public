#!/bin/bash
echo "=== Fixing Grayscale Config ==="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# 1. Copy all configs fresh
echo "[1/5] Copying configs..."
cp -r "$REPO_DIR"/hypr "$REPO_DIR"/alacritty "$REPO_DIR"/waybar "$REPO_DIR"/wofi "$REPO_DIR"/wlogout "$REPO_DIR"/fastfetch "$REPO_DIR"/dunst ~/.config/

# 2. Remove old alacritty configs that might override ours
echo "[2/5] Cleaning old alacritty configs..."
rm -f ~/.config/alacritty/alacritty.yml 2>/dev/null
rm -f ~/.alacritty.yml 2>/dev/null
rm -f ~/.alacritty.toml 2>/dev/null

# 3. Install grayscale nvim colorscheme (non-destructive to existing config)
echo "[3/5] Setting up grayscale nvim..."
mkdir -p ~/.config/nvim/colors ~/.config/nvim/after/plugin

cp "$REPO_DIR/nvim/colors/grayscale.lua" ~/.config/nvim/colors/
cp "$REPO_DIR/nvim/after/plugin/grayscale.lua" ~/.config/nvim/after/plugin/
echo "  -> installed grayscale colorscheme"

cp "$REPO_DIR/nvim/init.lua" ~/.config/nvim/
echo "  -> init.lua updated"

# 4. Setup bashrc
echo "[4/6] Setting up bashrc..."
if [ -f "$REPO_DIR/bashrc" ]; then
    cp "$REPO_DIR/bashrc" ~/.bashrc
    echo "  -> bashrc installed"
fi

# 5. Generate wallpaper if missing
echo "[5/6] Checking wallpaper..."
mkdir -p ~/Pictures/wallpaper
if [ ! -f ~/Pictures/wallpaper/grayscale-geo.png ]; then
    if [ -f "$REPO_DIR/scripts/generate-wallpaper.py" ]; then
        python3 "$REPO_DIR/scripts/generate-wallpaper.py" ~/Pictures/wallpaper/grayscale-geo.png
        echo "  -> wallpaper generated"
    fi
fi
ln -sf ~/Pictures/wallpaper/grayscale-geo.png ~/Pictures/wallpaper/current.png
echo "  -> wallpaper symlink set"

# 6. Restart waybar, reload hyprpaper and hyprland
echo "[6/6] Reloading..."
killall waybar 2>/dev/null
sleep 0.3
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css &
disown

hyprctl hyprpaper unload all 2>/dev/null
hyprctl hyprpaper preload ~/Pictures/wallpaper/current.png 2>/dev/null
# Apply wallpaper to all currently connected monitors
while read -r mon; do
    [ -n "$mon" ] || continue
    hyprctl hyprpaper wallpaper "$mon,~/Pictures/wallpaper/current.png" 2>/dev/null
done < <(hyprctl monitors -j 2>/dev/null | jq -r '.[].name')

hyprctl reload

echo ""
echo "=== Done! ==="
echo "Close and reopen Alacritty to apply terminal colors."
echo "Nvim: grayscale colorscheme installed. Open nvim to verify."
