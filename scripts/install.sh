#!/bin/bash
set -e

echo "=== Hyprland Grayscale Config - Install ==="
echo ""

# 1. Install all dependencies
echo "[1/6] Installing packages..."
sudo pacman -S --needed --noconfirm \
    hyprland hyprlock hyprpaper \
    waybar dunst wlogout wofi \
    alacritty thunar \
    ttf-jetbrains-mono \
    brightnessctl playerctl \
    pavucontrol pipewire wireplumber \
    neovim \
    fastfetch jq python

echo ""

# 2. Install AUR packages (if yay is available)
if command -v yay &> /dev/null; then
    echo "[2/6] Installing AUR packages..."
    yay -S --needed --noconfirm hyprshot
else
    echo "[2/6] yay not found, skipping AUR packages (hyprshot)"
    echo "  Install yay first: https://github.com/Jguer/yay"
fi

echo ""

# 3. Detect script location and config source
echo "[3/6] Copying configs..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

CONFIG_DIRS=(hypr alacritty waybar wofi wlogout fastfetch dunst)

for dir in "${CONFIG_DIRS[@]}"; do
    if [ -d "$REPO_DIR/$dir" ]; then
        echo "  -> ~/.config/$dir/"
        cp -r "$REPO_DIR/$dir" ~/.config/
    else
        echo "  !! $dir/ not found in repo, skipping"
    fi
done

echo ""

# 4. Setup Neovim grayscale
echo "[4/6] Setting up Neovim grayscale colorscheme..."
mkdir -p ~/.config/nvim/colors ~/.config/nvim/after/plugin

if [ -d "$REPO_DIR/nvim" ]; then
    cp "$REPO_DIR/nvim/colors/grayscale.lua" ~/.config/nvim/colors/
    cp "$REPO_DIR/nvim/after/plugin/grayscale.lua" ~/.config/nvim/after/plugin/

    if [ ! -f ~/.config/nvim/init.lua ] && [ ! -f ~/.config/nvim/init.vim ]; then
        cp "$REPO_DIR/nvim/init.lua" ~/.config/nvim/
        echo "  -> created ~/.config/nvim/init.lua"
    else
        echo "  -> existing nvim config preserved, grayscale colorscheme installed"
    fi
fi

echo ""

# 5. Setup bashrc
echo "[5/7] Setting up bashrc..."
if [ -f "$REPO_DIR/bashrc" ]; then
    cp "$REPO_DIR/bashrc" ~/.bashrc
    echo "  -> bashrc installed (fastfetch on terminal open)"
fi

echo ""

# 6. Generate wallpaper and create directories
echo "[6/7] Setting up wallpaper..."
mkdir -p ~/Pictures/wallpaper ~/Pictures/screenshots
chmod +x "$REPO_DIR/scripts/wallpaper-random.sh" 2>/dev/null || true

if [ -f "$REPO_DIR/scripts/generate-wallpaper.py" ]; then
    python3 "$REPO_DIR/scripts/generate-wallpaper.py" ~/Pictures/wallpaper/grayscale-geo.png
    ln -sf ~/Pictures/wallpaper/grayscale-geo.png ~/Pictures/wallpaper/current.png
    echo "  -> grayscale wallpaper generated and set"
else
    echo "  !! generate-wallpaper.py not found"
fi

echo ""

# 7. Verify installation
echo "[7/7] Verifying..."
MISSING=""
for cmd in alacritty waybar dunst hyprlock hyprpaper wofi; do
    if ! command -v $cmd &> /dev/null; then
        MISSING="$MISSING $cmd"
    fi
done

if [ -z "$MISSING" ]; then
    echo "  All packages installed OK"
else
    echo "  MISSING:$MISSING"
    echo "  Run: sudo pacman -S$MISSING"
fi

echo ""
echo "=== Done! ==="
echo ""
echo "Now either:"
echo "  1. Log out and log back in"
echo "  2. Or run: bash $(dirname "$0")/fix-all.sh"
echo ""
echo "Keybinds:"
echo "  SUPER+Q / SUPER+Enter  -> Terminal (Alacritty)"
echo "  SUPER+R                -> App launcher (Wofi)"
echo "  SUPER+B                -> Browser"
echo "  SUPER+E                -> File manager"
echo "  SUPER+C                -> Close window"
echo "  SUPER+1-0              -> Workspaces"
echo ""
