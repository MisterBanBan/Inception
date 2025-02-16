FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

# Définition des arguments pour l'initialisation de la BDD
ARG MYSQL_DATABASE=wordpress
ARG MYSQL_USER=wp_user
ARG MYSQL_PASSWORD=wp_pass
ARG MYSQL_ROOT_PASSWORD=root_pass

ENV MYSQL_DATABASE=${MYSQL_DATABASE} \
    MYSQL_USER=${MYSQL_USER} \
    MYSQL_PASSWORD=${MYSQL_PASSWORD} \
    MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}

# Installer MariaDB Server
RUN apt update -y && apt upgrade -y && apt install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copier la configuration personnalisée de MariaDB
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Créer le répertoire pour le socket et ajuster les permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Créer le fichier d'initialisation
RUN echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" > /tmp/init.sql && \
    echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> /tmp/init.sql && \
    echo "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';" >> /tmp/init.sql && \
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> /tmp/init.sql && \
    echo "FLUSH PRIVILEGES;" >> /tmp/init.sql

# Exposer le port de MariaDB
EXPOSE 3306

# Démarrer MariaDB en mode premier plan et exécuter le fichier d'initialisation
CMD ["mysqld", "--bind-address=0.0.0.0", "--init-file=/tmp/init.sql"]
