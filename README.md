# Hyprland Grayscale Config

Minimal monochrome Hyprland rice. Pure grayscale, no color noise.

Public, device-agnostic template. After install, set your monitors and browser.

## Dependencies

Arch / pacman:

```bash
sudo pacman -S hyprland hyprlock hyprpaper hyprshot \
    waybar dunst wlogout wofi \
    alacritty thunar firefox \
    ttf-jetbrains-mono \
    brightnessctl playerctl \
    pavucontrol pipewire wireplumber \
    fastfetch jq
```

Optional AUR (`yay`): `hyprshot` if not in repos.

## Install (fresh Hyprland)

```bash
git clone https://github.com/YOUR_USER/Hyprland-config.git ~/Documents/Hyprland-config
cd ~/Documents/Hyprland-config
bash scripts/install.sh
```

Then set monitors for **this** machine:

```bash
hyprctl monitors
# edit ~/.config/hypr/hyprland.conf  →  monitor = ...
hyprctl reload
# or: bash scripts/fix-all.sh
```

Logout/login also works.

## What gets installed

Copied into `~/.config/`: `hypr`, `alacritty`, `waybar`, `wofi`, `wlogout`, `fastfetch`, `dunst`, plus a grayscale Neovim colorscheme and a simple `~/.bashrc`.

Obsidian settings are **optional** and separate:

```bash
export OBSIDIAN_DOT="$HOME/Documents/MyVault/.obsidian"
bash scripts/obsidian-restore.sh
```

Only plugin/theme settings are synced — not your notes.

## Animations

In `hypr/hyprland.conf`:

```
source = ~/.config/hypr/animations-smooth.conf
# source = ~/.config/hypr/animations-snappy.conf
```

## Keybinds

| Key | Action |
|---|---|
| `SUPER + Return` / `SUPER + Q` | Terminal (Alacritty) |
| `SUPER + R` | App launcher (Wofi) |
| `SUPER + B` | Browser |
| `SUPER + E` | File manager (Thunar) |
| `SUPER + C` | Close window |
| `SUPER + L` | Lock screen |
| `SUPER + 1-0` | Switch workspace |
| `SUPER + SHIFT + 1-0` | Move window to workspace |
| `SUPER + TAB` | Previous workspace |
| `SUPER + `` ` `` | Scratchpad |
| `Print` | Screenshot (output) |
| `SUPER + SHIFT + S` | Screenshot (region) |
| `SUPER + SHIFT + O` | Restart Waybar |

Volume, brightness, and media keys work out of the box.

## Pointer speed

Hyprland `input:sensitivity` is software speed (`-1.0` .. `1.0`), not hardware DPI.
Generic mice often have fixed DPI; use `hyprctl devices` and an optional `device { ... }` block in `hyprland.conf`.

## Color Palette

| Name | Hex |
|---|---|
| bg | `#0a0a0a` |
| bg-alt | `#141414` |
| surface | `#1e1e1e` |
| border | `#333333` |
| text-muted | `#555555` |
| text-dim | `#888888` |
| text | `#e0e0e0` |
| white | `#ffffff` |

## Dual-monitor tip

If an HDMI display blanks while idle or workspace swipe feels stuttery, keep:

```
debug {
    vfr = false
}
```

and pin refresh rate explicitly instead of `preferred` when needed.
