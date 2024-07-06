#!/bin/bash

# Ensure script is run as root or with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root or use sudo."
    exit 1
fi

# Change to the cloned repository directory
cd /var/www/jot-dog-live

# Install dependencies with npm
npm install

# Run the server in a separate process
sudo nohup npm run live &

# Output success message
echo "Server setup complete and running in background."