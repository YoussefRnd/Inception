FROM debian:11

RUN apt-get update && apt-get install -y 

RUN apt-get install php && \
	php && \
	php-fpm && \
	php-mysql && \
	php-curl && \
	php-gd && \
	php-xml && \
	php-mbstring && \
	php-json && \
	php-zip && \
	php-imagick && \
	php-opcache && \
	wget && \
	unzip 

# Download Wordpress
RUN wget https://wordpress.org/latest.zip && \
	unzip latest.zip && \
	rm latest.zip && \
	mv wordpress /var/www/html


RUN  useradd -m -d /var/www/html/wordpress wordpress && \
	chown -R wordpress:wordpress /var/www/html/wordpress && \
	chmod -R 755 /var/www/html/wordpress

USER wordpress

WORKDIR /var/www/html/wordpress