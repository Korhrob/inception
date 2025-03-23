FROM	debian:bullseye-slim

RUN		apt-get update && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/*

RUN		mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

COPY	./conf/inception.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY	./tools/mariadb-entrypoint.sh /usr/local/bin/mariadb-entrypoint.sh
RUN		chmod +x /usr/local/bin/mariadb-entrypoint.sh

RUN		mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

EXPOSE	3306

ENTRYPOINT ["mariadb-entrypoint.sh"]