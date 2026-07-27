#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status
set -e

APP_NAME="lazy-nyaa"
REPO="Asad-Naseer/lazy-nyaa"
INSTALL_DIR="$HOME/.local/bin"

# Ensure the install directory exists
mkdir -p "$INSTALL_DIR"

echo "Downloading $APP_NAME..."

# Replace this URL with your hosting location. 
# This example uses a GitHub Releases URL.
URL="https://github.com/$REPO/releases/download/V1.0/$APP_NAME"

# Download the binary
curl -sSL -o "$INSTALL_DIR/$APP_NAME" "$URL"

# Make the binary executable
chmod +x "$INSTALL_DIR/$APP_NAME"

echo "$APP_NAME installed successfully in $INSTALL_DIR!"
echo "Run by typing 'lazy-nyaa' in your terminal anywhere!"

# Verify if the installation directory is in the user's current PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "Warning: $INSTALL_DIR is not in your current PATH."
    echo "To run '$APP_NAME' from anywhere, add it to your shell configuration."
    echo "For example, add the following line to your ~/.bashrc or ~/.zshrc file:"
    echo "  export PATH=\"\$PATH:\$HOME/.local/bin\""
fi
