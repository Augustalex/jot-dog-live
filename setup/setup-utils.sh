#!/bin/bash

# Ensure script is run as root or with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root or use sudo."
    exit 1
fi

# Update and install required packages
apt update && apt upgrade -y
apt install -y curl git

# Output success message
echo "Server setup complete and running in background."