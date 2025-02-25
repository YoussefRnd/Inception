FROM debian:11

RUN apt-get update && apt-get install -y --no-install-recommends \
  vsftpd \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./tools/vsftpd.conf /etc/vsftpd.conf

COPY ./tools/setup_ftp.sh /usr/local/bin/setup_ftp.sh

RUN chmod +x /usr/local/bin/setup_ftp.sh

EXPOSE 21 30000-30100

ENTRYPOINT [ "/usr/local/bin/setup_ftp.sh" ]