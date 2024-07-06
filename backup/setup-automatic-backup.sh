#!/bin/bash

# Ensure the script is run as sudo
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo."
  exit 1
fi

# Path to the backup script
BACKUP_SCRIPT="/var/www/jot-dog-live/backup/run-backup.sh"

# Ensure the backup script is executable
chmod +x "$BACKUP_SCRIPT"

# Add cron job
(crontab -l 2>/dev/null; echo "0 2 * * * $BACKUP_SCRIPT") | crontab -

echo "Cron job has been set up to run the backup script daily at 2 AM."