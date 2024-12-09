# Use the last stable version of Debian
FROM debian:11

# Install necessary packages
RUN apt update -y && apt upgrade -y && apt install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy custom MariaDB configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Create necessary directories and set permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Copy the initialization script
COPY tools/scriptsql.sh /usr/local/bin/scriptsql.sh
RUN chmod +x /usr/local/bin/scriptsql.sh

# Expose the default MariaDB port
EXPOSE 3306

# Start MariaDB using the script
ENTRYPOINT ["/usr/local/bin/scriptsql.sh"]
