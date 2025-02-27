#!/bin/bash

DB_USER_PASSWORD=$(cat /run/secrets/db_user_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_SECONDARY_PASSWORD=$(cat /run/secrets/wp_secondary_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Download WP-CLI if not already available
if [ ! -x "/usr/local/bin/wp" ]; then 
  echo "Downloading WP-CLI..."
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp
fi

# Check if WordPress is already installed
if [ ! -f "$WP_DIR/wp-config.php" ]; then
  echo "WordPress not found. Installing WordPress..."

  mkdir -p $WP_DIR
  cd ${WP_DIR}

  echo "Downloading WordPress using WP-CLI..."
  wp core download --allow-root
  
  echo "Creating wp-config.php..."
  wp config create --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_USER_PASSWORD}" --dbhost="${DB_HOST}" --allow-root

  echo "Installing WordPress..."
  wp core install --url="10.11.248.24" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root

  wp user create "${WP_SECONDARY_USER}" "${WP_SECONDARY_EMAIL}" --role="${WP_SECONDARY_ROLE}" --user_pass="${WP_SECONDARY_PASSWORD}" --allow-root

  wp theme install twentytwentyfour --activate --allow-root

  # add redis
  wp config set WP_REDIS_HOST redis --allow-root
  wp config set WP_REDIS_PORT 6379 --raw --allow-root
  wp plugin install redis-cache --activate --allow-root
  wp redis enable --allow-root


  echo "Setting file permissions..."
  chown -R www-data:www-data ${WP_DIR}
  chmod -R 755 ${WP_DIR}
fi

# Ensure the /run/php directory exists and has the correct permissions
mkdir -p /run/php
chown -R www-data:www-data /run/php

# Update PHP-FPM configuration to listen on port 9000
sed -i "s/^listen = .*/listen = 0.0.0.0:9000/" /etc/php/7.4/fpm/pool.d/www.conf

echo "Starting PHP-FPM..."
exec php-fpm7.4 -F
