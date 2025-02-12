FROM debian:11

RUN apt update && apt-get install -y --no-install-recommends \
	mariadb-server \
	&& apt clean && rm -rf /var/lib/apt/lists/*

COPY ./tools/install-mariadb.sh /usr/local/bin/install-mariadb.sh

RUN chmod +x /usr/local/bin/install-mariadb.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/install-mariadb.sh" ]