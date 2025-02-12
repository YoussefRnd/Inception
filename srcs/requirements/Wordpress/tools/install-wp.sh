#!/bin/bash

# Variables
WP_DIR="/var/www/wordpress"
DB_NAME=${DB_NAME:-wordpress}
DB_USER=${DB_USER:-wordpress}
DB_PASSWORD=${DB_PASSWORD:-wordpress}
DB_HOST=${DB_HOST:-mariadb}

# Check if WordPress is already installed
if [ ! -f "$WP_DIR/wp-config.php" ]; then
  echo "WordPress not found. Installing WordPress..."

  # Download WP-CLI if not already available
  if [ ! -x "/usr/local/bin/wp" ]; then 
    echo "Downloading WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
  fi

  mkdir -p $WP_DIR

  echo "Downloading WordPress using WP-CLI..."
  wp core download --path="$WP_DIR" --allow-root

  echo "Configuring WordPress..."
  cp "$WP_DIR/wp-config-sample.php" "$WP_DIR/wp-config.php"

  # Update wp-config.php with database connection details
  sed -i "s/database_name_here/$DB_NAME/" "$WP_DIR/wp-config.php"
  sed -i "s/username_here/$DB_USER/" "$WP_DIR/wp-config.php"
  sed -i "s/password_here/$DB_PASSWORD/" "$WP_DIR/wp-config.php"
  sed -i "s/localhost/$DB_HOST/" "$WP_DIR/wp-config.php"

  echo "Setting file permissions on $WP_DIR..."
  chown -R www-data:www-data "$WP_DIR"
  chmod -R 755 "$WP_DIR"
fi

# Ensure the /run/php directory exists and has the correct permissions
mkdir -p /run/php
chown -R www-data:www-data /run/php

# Update PHP-FPM configuration to listen on port 9000
sed -i "s/^listen = .*/listen = 0.0.0.0:9000/" /etc/php/7.4/fpm/pool.d/www.conf

echo "Starting PHP-FPM..."
exec php-fpm7.4 -F