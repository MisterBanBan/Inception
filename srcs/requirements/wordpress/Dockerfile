FROM debian:11

# Install PHP, WP-CLI, etc.
RUN apt update -y && apt upgrade -y && apt install -y \
    php7.4 \
    php-fpm \
    php-mysql \
    mariadb-client \
    curl

# Download WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy the auto-configuration script
COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

# Copy the www.conf file for php-fpm
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Create the run/php directory for php-fpm
RUN mkdir -p /run/php

# Expose port 9000
EXPOSE 9000

# Entrypoint et CMD
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]
