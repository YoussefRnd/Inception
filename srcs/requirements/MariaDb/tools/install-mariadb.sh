#!/bin/bash

# Variables
DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD:-root}
DB_NAME=${DB_NAME:-wordpress}
DB_USER=${DB_USER:-wordpress}
DB_PASSWORD=${DB_PASSWORD:-wordpress}

# Initialize the MariaDB data directory
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing MariaDB data directory..."
  mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# Start MariaDB server
echo "Starting MariaDB server..."
mysqld_safe --skip-networking &
pid="$!"

# Wait for the MariaDB server to start
echo "Waiting for MariaDB server to start..."
sleep 5

# Create the database and user
echo "Creating database and user..."
mysql -u root <<-EOSQL
  SET @@SESSION.SQL_LOG_BIN=0;
  SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${DB_ROOT_PASSWORD}');
  GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
  CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8 COLLATE utf8_general_ci;
  CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
  GRANT ALL ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL

# Stop MariaDB server
echo "Stopping MariaDB server..."
if ! kill -s TERM "$pid" || ! wait "$pid"; then
  echo >&2 'MariaDB initialization process failed.'
  exit 1
fi

echo "MariaDB setup completed."