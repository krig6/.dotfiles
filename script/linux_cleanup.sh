#!/bin/bash

set -e # Exit on error

echo "Cleaning up installed packages, configurations, and dotfiles..."

# Uninstall packages
echo "Removing installed packages..."
sudo apt remove --purge -y xclip nodejs npm build-essential tmux curl papirus-icon-theme
sudo apt autoremove -y
sudo apt clean
echo "System packages removed."

# Remove Neovim
echo "Removing Neovim..."
sudo rm -rf /opt/nvim
sudo rm -rf ~/.config/nvim
sudo rm -rf ~/.local/share/nvim
sudo rm -rf ~/.local/state/nvim
echo "Neovim removed."

# Remove LazyGit binary from /usr/local/bin/
echo "Removing LazyGit..."
sudo rm -rf /usr/local/bin/lazygit
# Remove LazyGit configuration and data directories
sudo rm -rf ~/.config/jesseduffield
sudo rm -rf ~/.config/lazygit
sudo rm -rf ~/.lazygit
sudo rm -rf ~/.local/state/lazygit
echo "LazyGit removed."

# Remove Alacritty
echo "Removing Alacritty..."
sudo apt-get remove --purge -y alacritty
sudo rm -rf ~/.config/alacritty
echo "Alacritty removed."

# Remove Tmux
echo "Removing Tmux"
sudo rm -rf ~/.tmux/plugins/tpm
sudo rm -rf ~/.tmux
echo "Tmux removed."

# Remove Fonts
echo "Removing custom fonts..."
sudo rm -rf ~/.local/share/fonts/custom
fc-cache -fv
echo "Fonts removed."

# Remove Xmodmap
echo "Removing Xmodmap..."
sudo rm ~/.Xmodmap
echo "Xmodmap removed."

# Remove Gruvbox-Dark GTK theme
echo "Removing Gruvbox-Dark theme..."
sudo rm -rf ~/.themes/Gruvbox-Dark
echo "GTK theme removed."

# Remove Polybar
echo "Removing polybar..."
sudo apt-get remove --purge -y polybar
sudo rm -rf ~/.config/polybar
killall polybar
echo "Polybar removed."

# Remove dotfiles folder and symlink
echo "Removing dotfiles and symlinks..."
sudo rm -rf ~/.dotfiles
sudo rm -f ~/.bashrc ~/.bash_aliases
sudo rm -f ~/.tmux.conf ~/.tmux_startup.sh
echo "Dotfiles and symlinks removed."

echo "Cleanup complete!"
