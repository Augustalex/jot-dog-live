#!/bin/bash

# Update and install PostgreSQL
sudo apt update
sudo apt install -y postgresql postgresql-contrib

# Start and enable PostgreSQL service
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Configure PostgreSQL to accept remote connections
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/*/main/postgresql.conf

# Allow access to PostgreSQL from any IP address
echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a /etc/postgresql/*/main/pg_hba.conf

# Restart PostgreSQL to apply changes
sudo systemctl restart postgresql

# Create a new PostgreSQL user and database
sudo -u postgres psql -c "CREATE USER agge WITH PASSWORD 'g3MxM6ipHfQgvYJywSBMrWGEbBOSRyhZYRcHTxnRoMc=';"
sudo -u postgres psql -c "CREATE DATABASE pocketdog OWNER agge;"

# Print out the access details
echo "PostgreSQL has been installed and configured."