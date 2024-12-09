#the last version of stable debian
FROM debian:11

#Install package
RUN apt update && apt install -y \
    nginx \
    openssl

#Directory to store the secure key
RUN mkdir -p /etc/nginx/ssl

## Store Nginx configuration files
RUN mkdir -p /var/run/nginx

#This command generates a self-signed certificate and a private key for Nginx using OpenSSL, and stores them in the /etc/nginx/ssl directory.
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=afavier.42.fr/UID=afavier"

#copies the nginx.conf configuration file from the conf folder to the Nginx conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

#Sets permissions and ownership of the /var/www/html directory for Nginx
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

#Starts Nginx in non-daemon mode to keep it running in the foreground.
CMD [ "nginx", "-g", "daemon off;" ]

