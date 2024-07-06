#!/bin/bash

# Ensure the script is run as sudo
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo."
  exit 1
fi

# Define paths and variables
SOURCE_DB="/var/www/jot-dog-live/db.sqlite"
BACKUP_DIR="/var/backups/jot-dog-live"
DATE=$(date +'%Y-%m-%d')
BACKUP_FILE="db.$DATE.sqlite"
MAX_BACKUPS=100

# Create backup directory if it does not exist
mkdir -p "$BACKUP_DIR"

# Copy the database file to the backup directory with the new name
cp "$SOURCE_DB" "$BACKUP_DIR/$BACKUP_FILE"

# Ensure the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup successful: $BACKUP_DIR/$BACKUP_FILE"
else
  echo "Backup failed."
  exit 1
fi

# Remove the oldest backup if more than MAX_BACKUPS exist
BACKUP_COUNT=$(ls -1 "$BACKUP_DIR" | wc -l)

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
  OLDEST_BACKUP=$(ls -1 "$BACKUP_DIR" | head -n 1)
  rm -f "$BACKUP_DIR/$OLDEST_BACKUP"
  echo "Removed oldest backup: $BACKUP_DIR/$OLDEST_BACKUP"
fi

echo "Backup script completed."