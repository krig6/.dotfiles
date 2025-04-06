#!/bin/bash

set -e # Exit on error

# Ensure input is taken from the terminal
exec </dev/tty

# Prompt for WSL username and PC username
read -p "Enter your WSL username: " WSL_USERNAME
read -p "Enter your PC username: " PC_USERNAME

# Update and install required packages
echo "Updating system and installing essential packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y xclip nodejs npm build-essential tmux

# Copy Alacritty configuration files
echo "Copying Alacritty configuration files..."
sudo cp -r /home/$WSL_USERNAME/.dotfiles/alacritty/windows /mnt/c/Users/$PC_USERNAME/AppData/Roaming/alacritty

# Install Neovim
echo "Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
mkdir -p ~/.config

# Install Lazygit
echo "Installing LazyGit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xzf lazygit.tar.gz lazygit
sudo mv lazygit /usr/local/bin/
rm lazygit.tar.gz

# Create symlinks for configurations
echo "Creating symlinks..."
ln -sfn ~/.dotfiles/bash/bashrc ~/.bashrc
ln -sfn ~/.dotfiles/bash/windows/bash_aliases ~/.bash_aliases
ln -sfn ~/.dotfiles/nvim ~/.config/nvim
ln -sfn ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sfn ~/.dotfiles/tmux/tmux_startup.sh ~/.tmux_startup.sh

# Link fonts
echo "Linking fonts..."
mkdir -p ~/.local/share/fonts
ln -sfn ~/.dotfiles/fonts/ ~/.local/share/fonts/custom
fc-cache -fv

# Save username to ~/.bashrc if not already present
echo "Saving PC_USERNAME in bash config..."
grep -qxF "export PC_USERNAME=\"$PC_USERNAME\"" ~/.bashrc || echo "export PC_USERNAME=\"$PC_USERNAME\"" >>~/.bashrc

# This is for when using windows_cleanup_tool.sh
export PC_USERNAME="$PC_USERNAME"

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
