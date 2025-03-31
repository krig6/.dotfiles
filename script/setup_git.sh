#!/bin/bash

set -e # Exit on error

# Update and install required packages
echo "Updating system and installing git..."
sudo apt update && sudo apt upgrade -y
sudo apt install git -y

# Promp for Git username and Git email
read -p "Enter your Git username: " GIT_USER
read -p "Enter your Git email: " GIT_EMAIL

echo "Git username and email have been set permanently."

# Git Configuration
echo "Configuring Git..."
git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global pull.rebase false

# Check and generate SSH key automatically
echo "Generating SSH key..."

# Check if SSH key already exists, if not, generate it
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  ssh-keygen -t ed25519 -C "$GIT_EMAIL" -N "" -f "$HOME/.ssh/id_ed25519"
fi

# Start the SSH agent and add the generated key
eval "$(ssh-agent -s)"
ssh-add "$HOME/.ssh/id_ed25519"

# Output the SSH key to the terminal (automated without requiring manual copy-paste)
echo "Your SSH key has been generated. Copy and add it to GitHub:"
cat "$HOME/.ssh/id_ed25519.pub"

echo "Setup complete! Please add the SSH key to your GitHub account."

# export GIT_USER="your_git_username"
# export GIT_EMAIL="your_email@example.com"
