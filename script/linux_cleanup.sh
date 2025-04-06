#!/bin/bash

set -e # Exit on error

echo "Cleaning up installed packages, configurations, and dotfiles..."

# Uninstall packages
echo "Removing installed packages..."
sudo apt remove --purge -y xclip nodejs npm build-essential tmux curl papirus-icon-theme
sudo apt autoremove -y
sudo apt clean

# Remove Neovim
echo "Removing Neovim..."
sudo rm -rf /opt/nvim
sudo rm -rf ~/.config/nvim
sudo rm -rf ~/.local/share/nvim
sudo rm -rf ~/.local/state/nvim

# Remove LazyGit binary from /usr/local/bin/
sudo rm -rf /usr/local/bin/lazygit
# Remove LazyGit configuration and data directories
sudo rm -rf ~/.config/jesseduffield
sudo rm -rf ~/.config/lazygit
sudo rm -rf ~/.lazygit
sudo rm -rf ~/.local/state/lazygit

# Remove Alacritty
echo "Removing Alacritty..."
sudo apt-get remove --purge -y alacritty
sudo rm -rf ~/.config/alacritty
sudo rm /usr/bin/alacritty

# Remove Tmux
echo "Removing Tmux"
sudo rm -rf ~/.tmux/plugins/tpm
sudo rm -rf ~/.tmux

# Remove Fonts
sudo rm -rf ~/.local/share/fonts/custom
fc-cache -fv

# Remove Xmodmap
sudo rm ~/.Xmodmap

# Remove Gruvbox-Dark GTK theme
sudo rm -rf ~/.themes/Gruvbox-Dark

# Remove Polybar
sudo apt-get remove --purge -y polybar
sudo rm -rf ~/.config/polybar
sudo rm /usr/bin/polybar
killall polybar

# Remove dotfiles folder and symlink
echo "Removing dotfiles and symlinks..."
sudo rm -rf ~/.dotfiles
sudo rm -f ~/.bashrc ~/.bash_aliases
sudo rm -f ~/.tmux.conf ~/.tmux_startup.sh

echo "Cleanup complete!"
