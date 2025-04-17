FROM	debian:bullseye-slim

RUN		apt-get update && apt-get install -y \
		nginx \
		openssl \
		&& rm -rf /var/lib/apt/lists/*

RUN		rm -rf /etc/nginx/sites-enabled/default
RUN		rm -rf /var/www/html/index.nginx-debian.html

COPY	--chown=www-data:www-data ./conf/nginx.conf /etc/nginx/nginx.conf
COPY	--chown=www-data:www-data ./conf/default.conf /tmp/default.conf

#RUN	chown -R www-data:www-data /etc/nginx

WORKDIR	/var/www/html

EXPOSE	443

COPY	./tools/nginx-entrypoint.sh /usr/local/bin/nginx-entrypoint.sh
RUN		chmod +x /usr/local/bin/nginx-entrypoint.sh

ENTRYPOINT	["nginx-entrypoint.sh"]
