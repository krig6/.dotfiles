#!/bin/bash

set -e # Exit on error

# Update and install required packages
echo "Updating system and installing essential packages..."
sudo apt update
sudo apt install -y xclip nodejs npm build-essential tmux curl papirus-icon-theme polybar rofi picom openbox xinit feh flameshot thunar mousepad ripgrep imagemagick bc
echo "Done installing base packages."

# Install Brave
curl -fsS https://dl.brave.com/install.sh | sudo sh

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

# Install eza
echo "Installing eza"
sudo apt update
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
echo "Done installing eza."

# Create symlinks for configurations
echo "Creating general config symlinks..."
ln -sfn ~/.dotfiles/bash/.bashrc ~/.bashrc
ln -sfn ~/.dotfiles/bash/linux/bash_aliases ~/.bash_aliases
ln -sfn ~/.dotfiles/nvim ~/.config/nvim
ln -sfn ~/.dotfiles/x11/.xinitrc ~/.xinitrc
ln -sfn ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sfn ~/.dotfiles/tmux/tmux_startup.sh ~/.tmux_startup.sh
echo "Done creating general config symlinks."

# Create symlink for Xmodmap
# This Xmodmap is used to swap Caps Lock and Escape key
echo "Setting Xmodmap for Caps/Esc swap..."
ln -sfn ~/.dotfiles/x11/.Xmodmap ~/.Xmodmap
echo "Xmodmap setup complete."

# Create symlink for fonts
echo "Setting up fonts..."
mkdir -p ~/.local/share/fonts
ln -sfn ~/.dotfiles/fonts ~/.local/share/fonts/custom
fc-cache -fv
echo "Fonts installed and cache refreshed."

# Create symlink for themes directory
echo "Linking themes directory..."
ln -sfn ~/.dotfiles/themes/ ~/.themes
echo "Symlink created for themes directory."

# Create symlinks in ~/.config/script pointing to individual theme switcher scripts
mkdir -p ~/.config/script
ln -sfn ~/.dotfiles/script/rose-pine-theme.sh ~/.config/script/rose-pine-theme.sh
ln -sfn ~/.dotfiles/script/gruvbox-theme.sh ~/.config/script/gruvbox-theme.sh

# Create symlink for Polybar
echo "Linking Polybar config..."
ln -sfn ~/.dotfiles/polybar ~/.config/polybar
sleep 10
echo "Symlink for Polybar created!"

# Create symlink for Openbox
echo "Linking Openbox config..."
ln -sfn ~/.dotfiles/openbox ~/.config/openbox
sleep 10
echo "Symlink for Openbox created!"

# Create symlink for Picom
echo "Linking Picom config..."
ln -sfn ~/.dotfiles/picom ~/.config/picom
sleep 10
echo "Symlink for Picom created!"

# Create symlink for Rofi
echo "Linking Rofi config..."
ln -sfn ~/.dotfiles/rofi ~/.config/rofi
sleep 10
echo "Symlink for Rofi created!"

# Install i3lock-color
sudo apt install -y autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev libgif-dev
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./install-i3lock-color.sh

# Install betterlockscreen
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system
ln -sfn ~/.dotfiles/betterlockscreen/betterlockscreenrc ~/.config/betterlockscreenrc

# Create symlink for Pomodoro script
echo "Linking Pomodoro script..."
ln -sfn ~/.dotfiles/script/pomodoro.sh ~/pomodoro.sh
echo "Ensuring pomodoro script is executable..."
chmod +x ~/pomodoro.sh
echo "Pomodoro script ready."

# Making sure that tmux script is executable
echo "Ensuring tmux startup script is executable..."
chmod +x ~/.tmux_startup.sh
echo "Tmux script ready."

# Install TPM (Tmux Plugin Manager)
echo "Installing TPM..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "TPM installed"

# Polybar reminder
echo "If you're using a graphical session, you can launch Polybar manually: polybar top &"

# Prompt to install Tmux plugins
echo "Open tmux and press Prefix + I to install plugins."

echo "Setup complete!"
# Prompt to refresh source and apply changes
echo "To apply the changes, run: source ~/.bashrc or restart your terminal."
