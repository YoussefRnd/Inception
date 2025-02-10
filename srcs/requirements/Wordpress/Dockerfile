FROM debian:11

# Install packages and PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
	php php-fpm php-mysql php-curl php-gd php-xml php-mbstring \
	php-json php-zip php-opcache php-intl php-exif \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and set up WordPress
RUN wget https://wordpress.org/latest.zip -O wordpress.zip && \
	unzip wordpress.zip && rm wordpress.zip && \
	mv wordpress /var/www/wordpress && \
	useradd -m wordpress -d /var/www/wordpress && \
	chown -R wordpress:wordpress /var/www/wordpress && \
	chmod -R 755 /var/www/wordpress

# Set the working directory
WORKDIR /var/www/wordpress

RUN mkdir -p /run/php && chown -R wordpress:wordpress /run/php

ENTRYPOINT [ "php-fpm", "-F" ]

USER wordpress