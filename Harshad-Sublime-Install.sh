#!/bin/bash

# Author: Harshad Shah
# Description: Script to install Sublime Text on Ubuntu
# Date: February 4, 2025

# Function to check if command executed successfully
check_status() {
    if [ $? -eq 0 ]; then
        echo "✓ \$1"
    else
        echo "✗ Error: \$1 failed"
        exit 1
    fi
}

# Print welcome message
echo "Starting Sublime Text Installation..."
echo "======================================"

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (use sudo)"
    exit 1
fi

# Update system
echo "Updating system packages..."
apt update
check_status "System update"

# Install dependencies
echo "Installing required dependencies..."
apt install -y apt-transport-https ca-certificates curl software-properties-common
check_status "Dependencies installation"

# Add Sublime Text GPG key
echo "Adding Sublime Text GPG key..."
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor -o /usr/share/keyrings/sublimehq-archive.gpg
check_status "GPG key addition"

# Add Sublime Text repository
echo "Adding Sublime Text repository..."
echo "deb [signed-by=/usr/share/keyrings/sublimehq-archive.gpg] https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
check_status "Repository addition"

# Update package list
echo "Updating package list..."
apt update
check_status "Package list update"

# Install Sublime Text
echo "Installing Sublime Text..."
apt install -y sublime-text
check_status "Sublime Text installation"

echo "======================================"
echo "Installation completed successfully!"
echo "You can now launch Sublime Text by typing 'subl' in terminal"
echo "or by finding it in your applications menu."
