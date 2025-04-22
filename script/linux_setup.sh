#!/bin/bash

set -e # Exit on error

# Update and install required packages
echo "Updating system and installing essential packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y xclip nodejs npm build-essential tmux curl papirus-icon-theme polybar eza rofi picom openbox xinit xserver-xorg x11-xserver-utils x11-utils
echo "Done installing base packages."

# Install Neovim
echo "Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
mkdir -p ~/.config
echo "Done installing Neovim."

# Install Lazygit
echo "Installing LazyGit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xzf lazygit.tar.gz lazygit
sudo mv lazygit /usr/local/bin/
rm lazygit.tar.gz
echo "Done installing LazyGit."

# Install Alacritty
echo "Installing Alacritty..."
sudo apt install -y alacritty
echo "Done installing Alacritty."
echo "Creating symlink for Alacritty config..."
ln -sfn ~/.dotfiles/alacritty/linux ~/.config/alacritty
echo "Done setting Alacritty config."

# Create symlinks for configurations
echo "Creating general config symlinks..."
ln -sfn ~/.dotfiles/bash/.bashrc ~/.bashrc
ln -sfn ~/.dotfiles/bash/linux/bash_aliases ~/.bash_aliases
ln -sfn ~/.dotfiles/nvim ~/.config/nvim
ln -sfn ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sfn ~/.dotfiles/tmux/tmux_startup.sh ~/.tmux_startup.sh
echo "Done creating general config symlinks."

# Create symlink for Xmodmap
# This Xmodmap is used to swap Caps Lock and Escape key
echo "Setting Xmodmap for Caps/Esc swap..."
ln -sfn ~/.dotfiles/x11/.Xmodmap ~/.Xmodmap
xmodmap ~/.Xmodmap
echo "Xmodmap setup complete."

# Create symlink for fonts
echo "Setting up fonts..."
mkdir -p ~/.local/share/fonts
ln -sfn ~/.dotfiles/fonts ~/.local/share/fonts/custom
fc-cache -fv
echo "Fonts installed and cache refreshed."

# Create symlink for icons directory
echo "Linking icons directory..."
ln -sfn ~/.dotfiles/icons/ ~/.icons
echo "Symlink created for icons directory."

# Create symlink for themes directory
echo "Linking themes directory..."
ln -sfn ~/.dotfiles/themes/ ~/.themes
echo "Symlink created for themes directory."

# Create symlink for Polybar
echo "Linking Polybar config..."
ln -sfn ~/.dotfiles/polybar ~/.config/polybar
sleep 10
polybar top &
echo "Polybar launched!"

# Making sure that tmux script is executable
echo "Ensuring tmux startup script is executable..."
chmod +x ~/.tmux_startup.sh
echo "Tmux script ready."

# Install TPM (Tmux Plugin Manager)
echo "Installing TPM..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "TPM installed"

echo "Setup complete!"

# Prompt to install Tmux plugins
echo "Open tmux and press Prefix + I to install plugins."

# Prompt to refresh source and apply changes
echo "To apply the changes, run: source ~/.bashrc or restart your terminal."
