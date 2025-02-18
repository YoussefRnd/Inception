FROM debian:11

RUN apt update && apt-get install -y --no-install-recommends \
    mariadb-server \
    && apt clean && rm -rf /var/lib/apt/lists/*


# Create the directory for the MySQL socket and set ownership
# RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Copy SQL template
# COPY tools/init.sql.template /docker-entrypoint-initdb.d/init.sql.template

COPY tools/setup_mariadb.sh /usr/local/bin/setup_mariadb.sh
RUN chmod +x /usr/local/bin/setup_mariadb.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/setup_mariadb.sh" ]
