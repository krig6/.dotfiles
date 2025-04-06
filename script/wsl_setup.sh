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
echo "Done installing base packages."

# Copy Alacritty configuration files
echo "Copying Alacritty configuration files..."
sudo cp -r /home/$WSL_USERNAME/.dotfiles/alacritty/windows /mnt/c/Users/$PC_USERNAME/AppData/Roaming/alacritty
echo "Alacritty config copied to Windows AppData folder."

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

# Create symlinks for configurations
echo "Creating general config symlinks..."
ln -sfn ~/.dotfiles/bash/bashrc ~/.bashrc
ln -sfn ~/.dotfiles/bash/windows/bash_aliases ~/.bash_aliases
ln -sfn ~/.dotfiles/nvim ~/.config/nvim
ln -sfn ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sfn ~/.dotfiles/tmux/tmux_startup.sh ~/.tmux_startup.sh
echo "Done creating general config symlinks."

# Link fonts
echo "Setting up fonts..."
mkdir -p ~/.local/share/fonts
ln -sfn ~/.dotfiles/fonts ~/.local/share/fonts/custom
fc-cache -fv
echo "Fonts installed and cache refreshed."

# Save username to ~/.bashrc if not already present
echo "Saving PC_USERNAME in bash config..."
grep -qxF "export PC_USERNAME=\"$PC_USERNAME\"" ~/.bashrc || echo "export PC_USERNAME=\"$PC_USERNAME\"" >>~/.bashrc
echo "PC_USERNAME saved to ~/.bashrc"

# This is for when using windows_cleanup_tool.sh
export PC_USERNAME="$PC_USERNAME"

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
