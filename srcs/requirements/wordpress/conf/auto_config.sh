#!/bin/bash

# Attendre que la DB soit prête
while ! mysqladmin ping -h $MYSQL_HOST --silent --user=$MYSQL_USER --password=$MYSQL_PASSWORD; do
    echo "Waiting for mariadb to be ready..."
    sleep 1
done

# Aller dans le répertoire où WordPress est installé
cd /var/www/html

if [ -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress already initialized"
else
    echo "Initializing WordPress..."
    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=$MYSQL_HOST:3306 \
        --path='/var/www/html'

    wp core install --allow-root \
        --url=$WP_URL \
        --title="$WP_TITLE" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --path='/var/www/html'

    wp user create --allow-root \
        $WP_USER \
        $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD \
        --role=author \
        --path='/var/www/html'

    echo "WordPress setup complete"
fi

exec "$@"
