#!/bin/bash
set -e

REPO_URL="https://github.com/TaT22444/web-studio"
ARCHIVE_URL="$REPO_URL/archive/refs/heads/main.tar.gz"
INSTALL_DIR="$HOME/.cursor/skills"
TMP_DIR=$(mktemp -d)

trap 'rm -rf "$TMP_DIR"' EXIT

echo "=== web-studio installer ==="
echo ""

curl -sL "$ARCHIVE_URL" | tar xz -C "$TMP_DIR" || {
  echo "Error: ダウンロードに失敗しました"
  echo "URL: $ARCHIVE_URL"
  exit 1
}

mkdir -p "$INSTALL_DIR"

cp -R "$TMP_DIR/web-studio-main/skills/web-production" "$INSTALL_DIR/"
cp -R "$TMP_DIR/web-studio-main/skills/setup" "$INSTALL_DIR/"

echo "Installed:"
echo "  - $INSTALL_DIR/web-production/"
echo "  - $INSTALL_DIR/setup/"
echo ""
echo "Done! Cursor を再起動するとスキルが使えます。"
