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

# Remove LazyGit binary from /usr/local/bin/
sudo rm -rf /usr/local/bin/lazygit
# Remove the downloaded tarball
rm lazygit.tar.gz
# Remove LazyGit configuration and data directories
rm -rf ~/.config/jesseduffield
rm -rf ~/.config/lazygit
rm -rf ~/.lazygit
rm -rf ~/.local/state/lazygit

# Remove Alacritty
echo "Removing Alacritty..."
rm -rf ~/.config/alacritty

# Remove Tmux
echo "Removing Tmux"
rm -rf ~/.tmux/plugins/tpm
rm -rf ~/.tmux

# Remove Fonts
rm -rf ~/.local/share/fonts/custom
fc-cache -fv

# Remove Xmodmap
rm -rf ~/.Xmodmap
xmodmap ~/.Xmodmap

# Remove Gruvbox-Dark GTK theme
rm -rf ~/.themes/Gruvbox-Dark/

# Remove dotfiles folder and symlink
echo "Removing dotfiles and symlinks..."
rm -rf ~/.dotfiles
rm -f ~/.bashrc ~/.bash_aliases
rm -f ~/.tmux.conf ~/.tmux_startup.sh

echo "Cleanup complete!"
