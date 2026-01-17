#!/bin/bash
set -e

echo "Starting Git setup..."

# 1. Install Git and GitHub CLI
echo "Checking for Git and GitHub CLI..."
if ! command -v git &> /dev/null; then
    echo "Git not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y git
else
    echo "Git is already installed: $(git --version)"
fi

if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y gh
else
    echo "GitHub CLI is already installed: $(gh --version)"
fi

# 2. Configure Git Identity
echo "Configuring Git Identity..."
CURRENT_NAME=$(git config --global user.name || echo "")
CURRENT_EMAIL=$(git config --global user.email || echo "")

if [ -z "$CURRENT_NAME" ]; then
    read -p "Enter your Git Name: " NAME
    git config --global user.name "$NAME"
else
    echo "Git Name already set to: $CURRENT_NAME"
fi

if [ -z "$CURRENT_EMAIL" ]; then
    read -p "Enter your Git Email: " EMAIL
    git config --global user.email "$EMAIL"
else
    echo "Git Email already set to: $CURRENT_EMAIL"
fi

# 3. GitHub Authentication Note
echo "============================================================"
echo "Setup Complete!"
echo "============================================================"
echo "You have chosen to login via browser."
echo "To authenticate with GitHub, you can use the GitHub CLI (if installed) or HTTPS."
echo ""
echo "Command for browser login (via gh cli):"
echo "  gh auth login"
echo ""
echo "If strictly using HTTPS, just git clone your repo and you will be prompted for credentials."
