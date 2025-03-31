#!/bin/bash

set -e # Exit on error

echo "Cleaning up installed packages, configurations, and dotfiles..."

# Uninstall packages
echo "Removing installed packages..."
sudo apt remove --purge -y xclip nodejs npm build-essential tmux curl
sudo apt autoremove -y
sudo apt clean

# Remove Neovim
echo "Removing Neovim..."
sudo rm -rf /opt/nvim
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim/
rm -rf ~/.local/state/nvim/

# Remove Alacritty
echo "Removing Alacritty..."
rm -rf ~/.config/alacritty

# Remove Tmux
echo "Removing Tmux"
rm -rf ~/.tmux/plugins/tpm
rm -rf ~/.tmux

# Remove dotfiles folder and symlink
echo "Removing dotfiles and symlinks..."
rm -rf ~/.dotfiles
rm -f ~/.bashrc ~/.bash_aliases
rm -f ~/.tmux.conf ~/.tmux_startup.sh

echo "Cleanup complete!"
