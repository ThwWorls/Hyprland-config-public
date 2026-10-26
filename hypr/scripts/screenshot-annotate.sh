#!/usr/bin/env bash
# Region screenshot → satty annotation → clipboard + file
# Enter: copy annotated image to clipboard, save PNG, exit
set -euo pipefail

mkdir -p "$HOME/Pictures/screenshots"

hyprshot -m region -r -s | satty \
  --filename - \
  --fullscreen \
  --output-filename "$HOME/Pictures/screenshots/satty-%Y%m%d_%H%M%S.png" \
  --copy-command wl-copy \
  --actions-on-enter save-to-clipboard,save-to-file,exit \
  --early-exit copy,save \
  --initial-tool rectangle
