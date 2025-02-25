FROM debian:11

RUN apt update && apt-get install -y --no-install-recommends \
  php php-mysql wget \
  && apt clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html && \
  wget --no-check-certificate "https://www.adminer.org/latest.php" -O /var/www/html/index.php

EXPOSE 8080

ENTRYPOINT ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]