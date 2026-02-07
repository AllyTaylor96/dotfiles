#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from home directory to dotfiles in this repo
# Can be used to set up new systems/servers

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"

    # If target exists and is not a symlink to our dotfile
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ "$(readlink "$target")" != "$source" ]; then
            echo "Backing up existing $target"
            mv "$target" "$BACKUP_DIR/"
        fi
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$target")"

    # Create symlink
    if [ ! -L "$target" ]; then
        echo "Linking $target -> $source"
        ln -sf "$source" "$target"
    else
        echo "Already linked: $target"
    fi
}

# Install dotfiles
echo ""
echo "Creating symlinks..."

# Symlink .zshrc
if [ -f "$DOTFILES_DIR/.zshrc" ]; then
    create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
fi

# Symlink .vimrc
if [ -f "$DOTFILES_DIR/.vimrc" ]; then
    create_symlink "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
fi

# Symlink nvim config directory
if [ -d "$DOTFILES_DIR/nvim" ]; then
    create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
fi

echo ""
echo "Dotfiles installation complete!"
echo ""

# Check if backup directory is empty
if [ -z "$(ls -A "$BACKUP_DIR")" ]; then
    rmdir "$BACKUP_DIR"
    echo "No backups were needed."
else
    echo "Previous dotfiles backed up to: $BACKUP_DIR"
fi

