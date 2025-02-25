#!/bin/bash

FTP_PASSWORD=$(cat run/secrets/ftp_password)

useradd -M -d $WP_DIR -s /bin/bash $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
chmod -R 777 $WP_DIR

mkdir -p /var/run/vsftpd/empty
chown $FTP_USER:$FTP_USER /var/run/vsftpd/empty

exec /usr/sbin/vsftpd /etc/vsftpd.conf