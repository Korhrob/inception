FROM	debian:bullseye-slim

RUN		apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

RUN		mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

COPY	./conf/inception.cnf /etc/mysql/mariadb.conf.d/50-server.cnf


# Copy the startup script
COPY ./tools/startup.sh /startup.sh
RUN chmod +x /startup.sh

EXPOSE	3306

CMD ["/startup.sh"]