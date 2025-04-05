#!/bin/bash

set -e # Exit on error

# Update and install required packages
echo "Updating system and installing essential packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y xclip nodejs npm build-essential tmux curl polybar papirus-icon-theme

# Install Neovim
echo "Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
mkdir -p ~/.config/

# Install Lazygit
echo "Installing LazyGit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xzf lazygit.tar.gz lazygit
sudo mv lazygit /usr/local/bin/
rm lazygit.tar.gz

# Install Alacritty
echo "Installing Alacritty..."
sudo apt install -y alacritty
echo "Creating symlink for Alacritty config..."
ln -sfn ~/.dotfiles/alacritty/linux ~/.config/alacritty

# Create symlinks for configurations
echo "Creating symlinks..."
ln -sfn ~/.dotfiles/bash/bashrc ~/.bashrc
ln -sfn ~/.dotfiles/bash/linux/bash_aliases ~/.bash_aliases
ln -sfn ~/.dotfiles/nvim ~/.config/nvim
ln -sfn ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sfn ~/.dotfiles/tmux/tmux_startup.sh ~/.tmux_startup.sh

# Create symlink for Xmodmap
# This Xmodmap is used to swap Caps Lock and Escape key
ln -sfn ~/.dotfiles/x11/.Xmodmap ~/.Xmodmap
xmodmap ~/.Xmodmap

# Create symlink for fonts
echo "Creating symlink for fonts..."
mkdir -p ~/.local/share/fonts/
ln -sfn ~/.dotfiles/fonts/ ~/.local/share/fonts/custom
fc-cache -fv

#-Create symlink for Gruvbox-Dark GTK theme
echo "Creating symlink for Gruvbox-Dark theme..."
ln -sfn ~/.dotfiles/Gruvbox-Dark/ ~/.themes/Gruvbox-Dark

# Create symlink for Polybar
echo "Creating symlink for Polybar"
ln -sfn ~/.dotfiles/polybar ~/.config/polybar
killall polybar
polybar top &

# Making sure that tmux script is executable
chmod +x ~/.tmux_startup.sh

# Install TPM (Tmux Plugin Manager)
echo "Installing TPM..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Prompt to install Tmux plugins
echo "Open tmux and press Prefix + I to install plugins."

# Prompt to refresh source and apply changes
echo "Setup complete!"
echo "To apply the changes, run: source ~/.bashrc or restart your terminal."
