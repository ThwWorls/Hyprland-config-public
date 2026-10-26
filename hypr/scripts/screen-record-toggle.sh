#!/usr/bin/env bash
# Toggle region screen recording with wf-recorder (SUPER+SHIFT+R)
set -euo pipefail

OUTDIR="$HOME/Videos/recordings"
mkdir -p "$OUTDIR"

notify() {
  if command -v notify-send >/dev/null 2>&1; then
    notify-send -a "Screen record" "$@"
  fi
}

if pgrep -x wf-recorder >/dev/null 2>&1; then
  pkill -SIGINT wf-recorder
  notify "Stopped" "Saved under ~/Videos/recordings"
  exit 0
fi

if ! command -v wf-recorder >/dev/null 2>&1; then
  notify "Missing wf-recorder" "Install: sudo pacman -S wf-recorder"
  exit 1
fi

GEO="$(slurp)" || exit 1
FILE="$OUTDIR/rec-$(date +'%Y%m%d_%H%M%S').mp4"
notify "Recording…" "Select stop with SUPER+SHIFT+R"
wf-recorder -g "$GEO" -f "$FILE"
