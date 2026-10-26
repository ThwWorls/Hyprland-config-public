# Hyprland Grayscale Config

Minimal monochrome Hyprland rice. Pure grayscale, no color noise.

Public, device-agnostic template. After install, set your monitors and browser.

Repo: https://github.com/ThwWorls/Hyprland-config-public

## Dependencies

Arch / pacman:

```bash
sudo pacman -S hyprland hyprlock hyprpaper hyprshot \
    satty wf-recorder grim slurp wl-clipboard \
    waybar dunst wlogout wofi libnotify \
    alacritty thunar firefox \
    ttf-jetbrains-mono \
    brightnessctl playerctl \
    pavucontrol pipewire wireplumber \
    fastfetch jq
```

- `satty` — annotate screenshots (rectangles, arrows, brush) after `SUPER+SHIFT+S`
- `wf-recorder` + `slurp` — region screen recording toggle via `SUPER+SHIFT+R`

## Install (fresh Hyprland)

```bash
git clone https://github.com/ThwWorls/Hyprland-config-public.git ~/Documents/Hyprland-config-public
cd ~/Documents/Hyprland-config-public
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

Copied into `~/.config/`: `hypr` (including `hypr/scripts/`), `alacritty`, `waybar`, `wofi`, `wlogout`, `fastfetch`, `dunst`, plus a grayscale Neovim colorscheme and a simple `~/.bashrc`.

Creates `~/Pictures/screenshots` and `~/Videos/recordings`.

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
| `Print` | Screenshot whole monitor → clipboard + `~/Pictures/screenshots` |
| `SUPER + SHIFT + S` | Region screenshot → **satty** (draw/highlight) → save + clipboard |
| `SUPER + SHIFT + R` | Toggle region **video** recording (`~/Videos/recordings`) |
| `SUPER + SHIFT + O` | Restart Waybar |

Volume, brightness, and media keys work out of the box.

### Screenshot / record notes

Hyprland `bind = ...` lines live in `~/.config/hypr/keybinds.conf` only. Pasting them into a shell will error (`readline: no key sequence terminator`).

After `SUPER+SHIFT+S`, pick a region, then annotate in satty (rectangle/brush = red boxes, arrows, text). Save/copy exits.

`SUPER+SHIFT+R` once: select region and start recording. Again: stop and save MP4.

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
