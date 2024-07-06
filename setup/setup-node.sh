#!/bin/bash

# Set the project directory
PROJECT_DIR="/var/www/jot-dog-live"

# Navigate to the project directory
cd "$PROJECT_DIR" || { echo "Directory not found: $PROJECT_DIR"; exit 1; }

# Install Node.js LTS version
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt install -y nodejs

# Ensure npm is up to date (npm usually comes with Node.js, but let's update it)
npm install -g npm

# Run npm install
echo "Running npm install..."
npm install

echo "Operation completed."