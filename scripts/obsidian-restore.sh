#!/bin/bash
# Optional: restore Obsidian *settings* (not notes) from this repo.
# Set OBSIDIAN_DOT to your vault's .obsidian directory first.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
VAULT_CONFIG="${OBSIDIAN_DOT:-}"

if [ ! -d "$REPO_DIR/obsidian" ]; then
    echo "No obsidian config found in repo."
    exit 1
fi

if [ -z "$VAULT_CONFIG" ]; then
    echo "Set OBSIDIAN_DOT to your vault's .obsidian directory first."
    echo "Example: export OBSIDIAN_DOT=\"\$HOME/Documents/MyVault/.obsidian\""
    exit 1
fi

echo "Restoring Obsidian config to $VAULT_CONFIG ..."

mkdir -p "$VAULT_CONFIG"

cp -r "$REPO_DIR/obsidian/plugins" "$VAULT_CONFIG/"
cp -r "$REPO_DIR/obsidian/themes" "$VAULT_CONFIG/"

for f in appearance.json app.json community-plugins.json core-plugins.json graph.json templates.json types.json hotkeys.json; do
    [ -f "$REPO_DIR/obsidian/$f" ] && cp "$REPO_DIR/obsidian/$f" "$VAULT_CONFIG/"
done

echo ""
echo "Restored plugins:"
jq -r '.[]' "$VAULT_CONFIG/community-plugins.json" 2>/dev/null | sed 's/^/  - /'
echo ""
echo "Done! Restart Obsidian to apply."
