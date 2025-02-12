FROM debian:11

# Install PHP 7.4, FPM, required extensions, and other tools
RUN apt update && apt-get install -y --no-install-recommends \
    php7.4 php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-xml php7.4-mbstring \
    php7.4-json php7.4-zip php7.4-opcache php7.4-intl php7.4-exif curl \
    ca-certificates \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Copy the WordPress installation script
COPY ./tools/install-wp.sh /usr/local/bin/install-wp.sh

# Make the script executable
RUN chmod +x /usr/local/bin/install-wp.sh

# Expose the PHP-FPM port
EXPOSE 9000

# Run the WordPress installation script
ENTRYPOINT [ "/usr/local/bin/install-wp.sh" ]