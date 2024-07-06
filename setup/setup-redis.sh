#!/bin/bash

# Update package lists
sudo apt-get update

# Install Redis server
sudo apt-get install -y redis-server

# Configure Redis to start on boot
sudo systemctl enable redis-server.service

# Start Redis server
sudo systemctl start redis-server.service

# Verify that Redis is running
sudo systemctl status redis-server.service

# Output the port Redis is running on
echo "Redis is running on port 6379"

echo "Redis installation and setup complete."