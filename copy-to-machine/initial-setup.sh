#!/bin/bash

# Ensure script is run as root or with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root or use sudo."
    exit 1
fi

apt install -y git

# Output success message
echo "Server setup complete and running in background."
# Set the project directory and repository URL
PROJECT_DIR="/var/www/jot-dog-live"
REPO_URL="https://github.com/Augustalex/jot-dog-live.git"

# Check if the project directory exists
if [ -d "$PROJECT_DIR" ]; then
  echo "Project directory exists. Updating the repository..."
  cd "$PROJECT_DIR"
  git fetch origin
  git reset --hard origin/master
else
  echo "Project directory does not exist. Cloning the repository..."
  sudo git clone "$REPO_URL" "$PROJECT_DIR"
fi

echo "Operation completed."