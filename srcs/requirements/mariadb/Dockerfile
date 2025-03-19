FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD

# install MariaDB Server
RUN apt update -y && apt upgrade -y && apt install -y mariadb-server

# Copy custom configuration from MariaDB
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mariadb start && \
    mysql  -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" && \
    mysql  -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" && \
    mysql  -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';" && \
    mysql  -e "FLUSH PRIVILEGES;"

# expose port of MariaDB
EXPOSE 3306

# Start MariaDB in foreground mode and run the initialization file
CMD ["mysqld_safe"]