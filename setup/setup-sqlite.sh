#!/bin/bash

# Script to setup SQLite on Ubuntu

# Update package list
echo "Updating package list..."
sudo apt-get update -y

# Install SQLite
echo "Installing SQLite..."
sudo apt-get install -y sqlite3

# Verify SQLite installation
echo "Verifying SQLite installation..."
sqlite3 --version

# Create a directory for the database file (if it doesn't exist)
DB_DIR="/var/sqlite"
DB_FILE="$DB_DIR/database.sqlite"

echo "Creating directory for database at $DB_DIR..."
sudo mkdir -p $DB_DIR

# Set the correct permissions for the directory
echo "Setting permissions for $DB_DIR..."
sudo chmod 755 $DB_DIR

# Create a new SQLite database and setup the 'documents' table
echo "Creating SQLite database and setting up the table..."
sqlite3 $DB_FILE <<EOF
CREATE TABLE IF NOT EXISTS documents (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE,
  data TEXT
);
EOF

# Set correct permissions for the database file
echo "Setting permissions for the database file at $DB_FILE..."
sudo chmod 644 $DB_FILE

echo "SQLite setup completed successfully!"
echo "Database location: $DB_FILE"