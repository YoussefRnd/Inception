FROM debian:11

# Install packages and PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
	php php-fpm php-mysql php-curl php-gd php-xml php-mbstring \
	php-json php-zip php-opcache php-intl php-exif curl \
	ca-certificates \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /var/www/wordpress wordpress

COPY ./tools/install-wp.sh ./install-wp.sh

RUN chmod +x install-wp.sh

USER wordpress

EXPOSE 9000

CMD [ "sh", "install-wp.sh" ]