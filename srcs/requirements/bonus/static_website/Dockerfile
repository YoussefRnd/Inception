FROM debian:11

RUN apt update && apt-get install -y --no-install-recommends \
	python3 \
	&& apt clean && rm -rf /var/lib/apt/lists/*

COPY ./japan/ /app

WORKDIR /app

EXPOSE 80

ENTRYPOINT ["python3", "-m", "http.server", "80", "--bind", "0.0.0.0"]