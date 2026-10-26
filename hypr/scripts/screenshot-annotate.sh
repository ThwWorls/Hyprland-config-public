#!/usr/bin/env bash
# Region screenshot → satty annotation (draw/highlight) → save + clipboard
set -euo pipefail

mkdir -p "$HOME/Pictures/screenshots"

hyprshot -m region -r -s | satty \
  --filename - \
  --fullscreen \
  --output-filename "$HOME/Pictures/screenshots/satty-%Y%m%d_%H%M%S.png" \
  --early-exit all \
  --copy-command wl-copy \
  --initial-tool rectangle
