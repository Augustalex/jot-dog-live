#!/bin/bash

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