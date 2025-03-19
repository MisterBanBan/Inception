FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

# Définition des arguments pour l'initialisation de la BDD
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

# install MariaDB Server
RUN apt update -y && apt upgrade -y && apt install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy custom configuration from MariaDB
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Create the directory for the socket and adjust the permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql

#creat file to init
RUN mkdir -p /docker-entrypoint-initdb.d
COPY tools/init-db.sh /docker-entrypoint-initdb.d/

# expose port of MariaDB
EXPOSE 3306

# Start MariaDB in foreground mode and run the initialization file
ENTRYPOINT ["/docker-entrypoint-initdb.d/init-db.sh"]
CMD ["mysqld_safe"]