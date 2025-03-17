FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

# Définition des arguments pour l'initialisation de la BDD
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

# Installer MariaDB Server
RUN apt update -y && apt upgrade -y && apt install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copier la configuration personnalisée de MariaDB
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Créer le répertoire pour le socket et ajuster les permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Créer le fichier d'initialisation    probleme ici !!!!!
RUN mkdir -p /docker-entrypoint-initdb.d
COPY tools/init.sql /docker-entrypoint-initdb.d/


# Exposer le port de MariaDB
EXPOSE 3306

# Démarrer MariaDB en mode premier plan et exécuter le fichier d'initialisation
CMD ["mysqld_safe"]