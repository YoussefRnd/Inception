#!/bin/bash

# Variables
DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD:-root}
DB_NAME=${DB_NAME:-wordpress}
DB_USER=${DB_USER:-wordpress}
DB_PASSWORD=${DB_PASSWORD:-wordpress}

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
chmod -R 777 /run/mysqld
chmod -R 777 /var/lib/mysql

echo "Waiting for MariaDB server to start..."

if [ ! -d "/var/lib/mysq/wordpress" ]
{

echo "Creating database and user..."
mariadbd -u root --bootstrap <<-EOSQL
  USE mysql;
  FLUSH PRIVILEGES;
  SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${DB_ROOT_PASSWORD}');
  CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
  CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
  GRANT ALL ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
  FLUSH PRIVILEGES;
EOSQL

}

exec mariadbd -u root --bind-address=0.0.0.0

echo "MariaDB setup completed."