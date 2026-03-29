#!/bin/bash
set -e

REPO="https://github.com/TaT22444/web-studio.git"
INSTALL_DIR="$HOME/.cursor/skills"
TMP_DIR=$(mktemp -d)

trap 'rm -rf "$TMP_DIR"' EXIT

echo "=== web-studio installer ==="
echo ""

git clone --depth 1 "$REPO" "$TMP_DIR/web-studio" 2>/dev/null || {
  echo "Error: git clone に失敗しました"
  exit 1
}

mkdir -p "$INSTALL_DIR"

cp -R "$TMP_DIR/web-studio/skills/web-production" "$INSTALL_DIR/"
cp -R "$TMP_DIR/web-studio/skills/setup" "$INSTALL_DIR/"

echo "Installed:"
echo "  - $INSTALL_DIR/web-production/"
echo "  - $INSTALL_DIR/setup/"
echo ""
echo "Done! Cursor を再起動するとスキルが使えます。"
