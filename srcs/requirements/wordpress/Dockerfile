FROM debian:11

# Installer PHP, WP-CLI, etc.
RUN apt update -y && apt upgrade -y && apt install -y \
    wget \
    php7.4 \
    php-fpm \
    php-mysql \
    mariadb-client \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Désactiver phar.readonly
RUN sed -i 's/phar.readonly = On/phar.readonly = Off/' /etc/php/7.4/cli/php.ini

# Télécharger WordPress et l’extraire dans /var/www/html
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www \
    && cd /var/www \
    && tar -xzf wordpress-6.0-fr_FR.tar.gz \
    && rm wordpress-6.0-fr_FR.tar.gz \
    && mkdir -p /var/www/html \
    && mv wordpress/* html/ \
    && rmdir wordpress \
    && chown -R www-data:www-data /var/www/html

# Télécharger WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copier le script d'auto configuration
COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

# Copier le fichier www.conf pour php-fpm
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Créer le répertoire run/php pour php-fpm
RUN mkdir -p /run/php

# Exposer le port 9000
EXPOSE 9000

# Entrypoint et CMD
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]
