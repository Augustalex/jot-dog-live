#!/bin/bash

# Ensure the script is run as sudo
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo."
  exit 1
fi

# Navigate to the root location
cd /

# Define the project directory and setup directory
PROJECT_DIR="/var/www/jot-dog-live"
SETUP_DIR="$PROJECT_DIR/setup"

# Function to run a setup script from the setup directory
run_setup_script() {
  local script_name=$1
  local script_path="$SETUP_DIR/$script_name"
  if [ -f "$script_path" ]; then
    echo "Running $script_name..."
    bash "$script_path"
  else
    echo "Script not found: $script_path"
    exit 1
  fi
}

# Run shutdown script to kill processes on ports 1234 and 3124
SHUTDOWN_SCRIPT="/var/www/jot-dog-live/setup/shutdown.sh"
if [ -f "$SHUTDOWN_SCRIPT" ]; then
  echo "Running shutdown script to kill processes on ports 1234 and 3124..."
  bash "$SHUTDOWN_SCRIPT"
else
  echo "Shutdown script not found: $SHUTDOWN_SCRIPT"
  exit 1
fi

# Check if the project directory exists
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Project directory does not exist. Running initial setup..."
  if [ -f "/initial-setup.sh" ]; then
    bash /initial-setup.sh
  else
    echo "Initial setup script not found: /initial-setup.sh"
    exit 1
  fi
fi

# Navigate to the setup directory
cd "$SETUP_DIR" || { echo "Setup directory not found: $SETUP_DIR"; exit 1; }

# Run the normal setup scripts
run_setup_script "setup-utils.sh"
run_setup_script "setup-redis.sh"
run_setup_script "setup-repo.sh"
run_setup_script "setup-node.sh"

echo "All setup scripts have been run successfully."