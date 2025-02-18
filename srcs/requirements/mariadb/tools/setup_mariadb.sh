#!/bin/bash

DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_USER_PASSWORD=$(cat /run/secrets/db_user_password)

# Create necessary directories and set permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chmod 777 /run/mysqld

# Initialize the MariaDB data directory if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Create the init.sql file with the necessary SQL commands
cat <<EOF > init.sql
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Bootstrap the MariaDB server with the init.sql file
mariadbd --user=mysql --bootstrap < init.sql

# Start the MariaDB server
exec mariadbd --user=mysql --bind-address=0.0.0.0