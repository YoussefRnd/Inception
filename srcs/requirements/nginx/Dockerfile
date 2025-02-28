FROM debian:11

RUN apt update && apt-get install -y --no-install-recommends \
    nginx openssl \
    && apt clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/ssl/certs /etc/ssl/private &&\
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=MA/ST=Tangier/L=Tangier/O=1337/CN=yboumlak.42.fr"

# Copy custom Nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Expose the Nginx port
EXPOSE 443

# Start Nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]