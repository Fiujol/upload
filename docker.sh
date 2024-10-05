#!/bin/bash

# Update package lists
sudo apt-get update

# Install required packages without prompt
sudo apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

# Create keyrings directory for Docker GPG key
sudo mkdir -m 0755 -p /etc/apt/keyrings

# Download and add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker APT repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package lists again
sudo apt-get update

# Install Docker packages without prompt
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
wget https://openport.io/download/debian64/latest.deb
sudo dpkg -i latest.deb
sudo apt-get install -f

# Verify Docker installation
sudo docker --version

# Start the Docker daemon in the background
nohup sudo dockerd > /dev/null 2>&1 &

while ! sudo docker info > /dev/null 2>&1; do
    sleep 1
done

sudo docker run -p 6200:80 dorowu/ubuntu-desktop-lxde-vnc



