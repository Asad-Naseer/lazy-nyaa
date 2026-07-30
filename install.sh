#!/bin/bash

echo -e "\033[1;36mStarting lazy-nyaa installation...\033[0m"

# 0. Detect OS
OS="$(uname -s)"
if [ "$OS" = "Linux" ]; then
    echo "--> Detected Linux Operating System."
    URL="https://github.com/Asad-Naseer/lazy-nyaa/releases/download/V1.1/lazy-nyaa-linux-x64.tar.xz"
    FILE="lazy-nyaa-linux-x64.tar.xz"
elif [ "$OS" = "Darwin" ]; then
    echo "--> Detected macOS Operating System."
    URL="https://github.com/Asad-Naseer/lazy-nyaa/releases/download/V1.1/lazy-nyaa-mac.zip"
    FILE="lazy-nyaa-mac.zip"
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# 1. Create a safe temporary directory
echo "--> Creating temporary workspace..."
WORK_DIR=$(mktemp -d)
cd "$WORK_DIR" || exit

# 2. Download
echo "--> Downloading $FILE..."
curl -L -s -o "$FILE" "$URL"
echo -e "\033[1;32m    Download complete.\033[0m"

# 3. Extract
echo "--> Extracting $FILE..."
if [ "$OS" = "Linux" ]; then
    tar -xf "$FILE"
elif [ "$OS" = "Darwin" ]; then
    unzip -q "$FILE"
fi
echo -e "\033[1;32m    Extraction complete.\033[0m"

# 4. Setup Bin directory and move executable
echo "--> Ensuring ~/.local/bin/ exists..."
mkdir -p ~/.local/bin/

echo "--> Locating executable and moving to ~/.local/bin/..."
# This finds 'lazy-nyaa' no matter how the folders are structured inside the archive
BIN_PATH=$(find . -name "lazy-nyaa" -type f | head -n 1)

if [ -z "$BIN_PATH" ]; then
    echo -e "\033[1;31mError: Could not find 'lazy-nyaa' executable in the downloaded archive.\033[0m"
    exit 1
fi

mv "$BIN_PATH" ~/.local/bin/lazy-nyaa

echo "--> Making lazy-nyaa executable..."
chmod +x ~/.local/bin/lazy-nyaa

# 5. Clean up
echo "--> Cleaning up temporary files..."
cd ~
rm -rf "$WORK_DIR"
echo -e "\033[1;32m    Cleanup complete.\033[0m"

echo -e "\n\033[1;36mInstallation Finished! lazy-nyaa is now installed.\033[0m"
echo -e "\n\033[1;36mType 'lazy-nyaa' into the terminal to use!\033[0m"
echo -e "\033[1;33mNOTE: Ensure ~/.local/bin is added to your \$PATH in your .bashrc or .zshrc if it isn't already, then restart your terminal.\033[0m"
