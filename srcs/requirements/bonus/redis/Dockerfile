FROM debian:11

RUN apt update && apt-get install -y --no-install-recommends \
  redis-server \
  && apt clean && rm -rf /var/lib/apt/lists/*

RUN sed -i "s/^bind .*/bind 0.0.0.0/" /etc/redis/redis.conf

EXPOSE 6379

ENTRYPOINT [ "redis-server" ]

CMD [ "--protected-mode no" ]