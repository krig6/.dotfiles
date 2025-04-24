#!/bin/bash

set -e # Exit on error

echo "Cleaning up installed packages, configurations, and dotfiles..."

# Uninstall packages
echo "Removing installed packages..."
sudo apt purge -y xclip nodejs npm build-essential tmux curl papirus-icon-theme eza rofi picom openbox xinit feh flameshot thunar mousepad
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
sudo apt purge -y alacritty
sudo rm -rf ~/.config/alacritty
echo "Alacritty removed."

# Remove eza and related config
echo "Purging eza and cleaning up related files"
sudo apt purge -y eza
sudo rm -f /etc/apt/sources.list.d/gierens.list
sudo rm -f /etc/apt/keyrings/gierens.gpg

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

# Remove icons
echo "Removing icons..."
sudo rm -rf ~/.icons
echo "Icons removed."

echo "Fonts removed."
# Remove Xmodmap
echo "Removing Xmodmap..."
sudo rm ~/.Xmodmap
echo "Xmodmap removed."

# Remove GTK theme
echo "Removing themes..."
sudo rm -rf ~/.themes
echo "GTK themes removed."

# Remove symlinks for theme switcher scripts from ~/.config/script
sudo rm -rf ~/.config/script

# Remove Polybar
echo "Removing polybar..."
sudo apt purge -y polybar
sudo rm -rf ~/.config/polybar
echo "Polybar removed."

# Purge symlink for Openbox
echo "Purging Openbox config symlink..."
sudo apt purge -y openbox
sudo rm -rf ~/.config/openbox
sleep 2
echo "Openbox symlink purged!"

# Purge symlink for Picom
echo "Purging Picom config symlink..."
sudo apt purge -y picom
sudo rm -rf ~/.config/picom
sleep 2
echo "Picom symlink purged!"

# Purge symlink for Rofi
echo "Purging Rofi config symlink..."
sudo apt purge -y rofi
sudo rm -rf ~/.config/rofi
sleep 2
echo "Rofi symlink purged!"

echo "Cleanup complete!"
# Remove dotfiles folder and symlink
echo "Removing dotfiles and symlinks..."
sudo rm -rf ~/.dotfiles
sudo rm -f ~/.bashrc ~/.bash_aliases
sudo rm -f ~/.xinitrc
sudo rm -f ~/.tmux.conf ~/.tmux_startup.sh
echo "Dotfiles and symlinks removed."

echo "Cleanup complete!"
