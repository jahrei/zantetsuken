#!/bin/bash
# Install script for galaxias-ii dotfiles
# Symlinks dots/ to ~/.config and home/ dotfiles to ~

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
DOTS_DIR="$REPO_DIR/dots"
HOME_DIR="$REPO_DIR/home"

echo "Installing dotfiles from: $REPO_DIR"

# Symlink dots/ directories to ~/.config/
echo "Symlinking dots/ to ~/.config/..."
mkdir -p ~/.config

for dir in "$DOTS_DIR"/*/; do
    name=$(basename "$dir")
    target="$HOME/.config/$name"

    if [ -L "$target" ]; then
        echo "  Removing existing symlink: $target"
        rm "$target"
    elif [ -d "$target" ]; then
        echo "  Backing up existing dir: $target -> $target.bak"
        mv "$target" "$target.bak"
    fi

    echo "  Linking: $dir -> $target"
    ln -sf "$dir" "$target"
done

# Symlink home/ dotfiles to ~/
echo "Symlinking home/ dotfiles to ~..."
for file in "$HOME_DIR"/.*; do
    name=$(basename "$file")

    # Skip . and ..
    [ "$name" = "." ] || [ "$name" = ".." ] && continue

    target="$HOME/$name"

    if [ -L "$target" ]; then
        rm "$target"
    elif [ -f "$target" ]; then
        echo "  Backing up: $target -> $target.bak"
        mv "$target" "$target.bak"
    fi

    echo "  Linking: $file -> $target"
    ln -sf "$file" "$target"
done

echo "Done! You may need to restart your shell or reload configs."
