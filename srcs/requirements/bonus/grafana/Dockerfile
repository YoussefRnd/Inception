FROM debian:11

# Install prerequisites
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    gnupg2 \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add Grafana repository
RUN mkdir -p /etc/apt/keyrings && \
    wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor > /etc/apt/keyrings/grafana.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" > /etc/apt/sources.list.d/grafana.list

# Install Grafana
RUN apt-get update && apt-get install -y grafana && \
    rm -rf /var/lib/apt/lists/*

# Configure Grafana
EXPOSE 3000

# Start Grafana
ENTRYPOINT [ "/usr/sbin/grafana-server" ]
CMD [ "--homepath=/usr/share/grafana" ]