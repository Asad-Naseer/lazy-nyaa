#!/bin/bash

echo -e "\033[1;36mStarting lazy-nyaa installation...\033[0m"

# 0. Detect OS
OS="$(uname -s)"
if [ "$OS" = "Linux" ]; then
    echo "--> Detected Linux Operating System."
    URL="https://github.com/Asad-Naseer/lazy-nyaa/releases/download/V1.1/lazy-nyaa-linux-x64.tar.xz"
    FILE="lazy-nyaa-linux-x64.tar.xz"
    DIR="lazy-nyaa-linux-x64"
elif [ "$OS" = "Darwin" ]; then
    echo "--> Detected macOS Operating System."
    URL="https://github.com/Asad-Naseer/lazy-nyaa/releases/download/V1.1/lazy-nyaa-mac.zip"
    FILE="lazy-nyaa-mac.zip"
    DIR="lazy-nyaa-mac"
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# 1. Download to ~/
echo "--> Navigating to home directory (~/)"
cd ~/ || exit

echo "--> Downloading $FILE..."
curl -L -s -o "$FILE" "$URL"
echo -e "\033[1;32m    Download complete.\033[0m"

# 2. Extract
echo "--> Extracting $FILE..."
if [ "$OS" = "Linux" ]; then
    tar -xf "$FILE"
elif [ "$OS" = "Darwin" ]; then
    unzip -q "$FILE"
fi
echo -e "\033[1;32m    Extraction complete.\033[0m"

# 3. Setup Bin directory and move executable
echo "--> Ensuring ~/.local/bin/ exists..."
mkdir -p ~/.local/bin/

echo "--> Moving lazy-nyaa executable to ~/.local/bin/..."
mv "$DIR/lazy-nyaa" ~/.local/bin/

echo "--> Making lazy-nyaa executable..."
chmod +x ~/.local/bin/lazy-nyaa

# 4. Clean up
echo "--> Cleaning up downloaded files and folders..."
rm "$FILE"
rm -rf "$DIR"
echo -e "\033[1;32m    Cleanup complete.\033[0m"

echo -e "\n\033[1;36mInstallation Finished! lazy-nyaa is now installed.\033[0m"
echo -e "\033[1;33mNOTE: Ensure ~/.local/bin is added to your \$PATH in your .bashrc or .zshrc if it isn't already, then restart your terminal.\033[0m"