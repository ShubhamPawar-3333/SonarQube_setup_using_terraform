#!/bin/bash

# Stop the script on any error
set -e

# Update package index
echo "Updating package index..."
sudo apt-get update -y

# Install prerequisites
echo "Installing required packages..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Create keyrings directory (if not exists) and download Docker's GPG key
echo "Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker's repository to Apt sources
echo "Adding Docker repository to sources list..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again after adding Docker's repository
echo "Updating package index after adding Docker repository..."
sudo apt-get update -y

# Install Docker and its components
echo "Installing Docker and its plugins..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Optional: Add current user to Docker group (avoids needing sudo for Docker commands)
echo "Adding the current user to the Docker group (optional)..."
sudo usermod -aG docker $USER

echo "Installation complete. Please log out and log back in for group changes to take effect."
