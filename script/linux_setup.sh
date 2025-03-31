#!/bin/bash

set -e # Exit on error

# Update and install required packages
echo "Updating system and installing essential packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y xclip nodejs npm build-essential tmux curl

# Install Neovim
echo "Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
mkdir -p ~/.config/

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

# Making sure that tmux script is executable
chmod +x ~/.tmux_startup.sh

# Install TPM (Tmux Plugin Manager)
echo "Installing TPM..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Prompt to install Tmux plugins
echo "Setup complete! Open tmux and press Prefix + I to install plugins."
