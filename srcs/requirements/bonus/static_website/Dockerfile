FROM debian:11

RUN apt update && apt-get install -y --no-install-recommends \
  python3 \
  && apt clean && rm -rf /var/lib/apt/lists/*

COPY ./static_website_files/ /app

WORKDIR /app

EXPOSE 4242

ENTRYPOINT ["python3", "-m", "http.server", "4242", "--bind", "0.0.0.0"]