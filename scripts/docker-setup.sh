#!/bin/bash

# Exit on any error
set -e

echo "Starting Docker setup for Ubuntu..."

# 1. Update the apt package index and install packages to allow apt to use a repository over HTTPS
echo "Updating package index and installing prerequisites..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

# 2. Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# 3. Set up the repository
echo "Setting up Docker repository..."
echo \
  "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Install Docker Engine, containerd, and Docker Compose
echo "Installing Docker Engine, containerd, and Docker Compose..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 5. Post-installation steps
echo "Configuring user permissions..."
# Create the docker group if it doesn't exist (it usually does after install)
sudo groupadd -f docker

# Add the current user to the docker group
sudo usermod -aG docker "$USER"

echo "============================================================"
echo "Docker installed successfully!"
echo "============================================================"
echo "You have been added to the 'docker' group."
echo "Please log out and log back in (or restart your session) for the group membership to take effect."
echo "To test the installation after logging back in, run: docker run hello-world"
