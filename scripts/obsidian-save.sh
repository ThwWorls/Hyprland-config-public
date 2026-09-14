#!/bin/bash
# Optional: sync Obsidian *settings* (not notes) into this repo.
# Set your vault's .obsidian path, e.g.:
#   export OBSIDIAN_DOT="$HOME/Documents/MyVault/.obsidian"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
VAULT_CONFIG="${OBSIDIAN_DOT:-}"

if [ -z "$VAULT_CONFIG" ] || [ ! -d "$VAULT_CONFIG" ]; then
    echo "Set OBSIDIAN_DOT to your vault's .obsidian directory first."
    echo "Example: export OBSIDIAN_DOT=\"\$HOME/Documents/MyVault/.obsidian\""
    exit 1
fi

echo "Saving Obsidian config from $VAULT_CONFIG ..."

rm -rf "$REPO_DIR/obsidian/plugins" "$REPO_DIR/obsidian/themes"

cp -r \
    "$VAULT_CONFIG/plugins" \
    "$VAULT_CONFIG/themes" \
    "$REPO_DIR/obsidian/"

for f in appearance.json app.json community-plugins.json core-plugins.json graph.json templates.json types.json hotkeys.json; do
    [ -f "$VAULT_CONFIG/$f" ] && cp "$VAULT_CONFIG/$f" "$REPO_DIR/obsidian/"
done

echo ""
echo "Saved plugins:"
jq -r '.[]' "$REPO_DIR/obsidian/community-plugins.json" 2>/dev/null | sed 's/^/  - /'
echo ""
echo "Theme: $(jq -r '.cssTheme' "$REPO_DIR/obsidian/appearance.json" 2>/dev/null)"
echo ""
echo "Done! Review changes before committing (no note contents are copied)."
