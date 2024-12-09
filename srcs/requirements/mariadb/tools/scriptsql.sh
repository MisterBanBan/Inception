#!/bin/bash

# Launch MariaDB in background without network (for init) to up the security 
mysqld_safe --skip-networking &

#init timeout
TIMEOUT=60
# Wait for mariadb to be ready
# we loop on mysqladmin until success
while ! mysqladmin ping --silent; do
if [ $TIMEOUT -eq 0 ]; then
        echo "Timeout waiting for mariadb"
        exit 1
    fi
    echo "Waiting for mariadb to be ready..."
    TIMEOUT=$((TIMEOUT-1))
    sleep 1
done

# Initialize the database and users if necessary
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
  echo "Initializing MariaDB..."
  mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
fi

# stop MariaDB
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# reRun MariaDB in safety mode
exec mysqld_safe
