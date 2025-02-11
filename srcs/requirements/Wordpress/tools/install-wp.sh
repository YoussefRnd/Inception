#!/bin/sh

# Vars
WP_DIR="/var/www/wordpress"
WP_URL="https://wordpress.org/latest.zip"

# Chech if WordPress is already installed
if [ ! -f "$WP_DIR/wp-config.php" ]; then
  echo "Downloading WordPress..."
  if [ ! -f "$HOME/bin/wp" ]; then
    curl -sSL -o "$HOME/bin/wp" https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x "$HOME/bin/wp"
  fi

  echo "Configuring WordPress..."
  wp core download --path=$WP_DIR --allow-root

  chown -R wordpress:wordpress $WP_DIR
  chmod -R 755 $WP_DIR
fi

# Start services
echo "Starting services..."
exec php-fpm -F