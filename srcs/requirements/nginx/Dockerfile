FROM	debian:bullseye-slim

RUN		apt-get update && apt-get install -y \
		nginx \
		openssl \
		&& rm -rf /var/lib/apt/lists/*

RUN		rm -rf /etc/nginx/sites-enabled/default
RUN		rm -rf /var/www/html/index.nginx-debian.html

COPY	--chown=www-data:www-data ./conf/nginx.conf /etc/nginx/nginx.conf
COPY	--chown=www-data:www-data ./conf/default.conf /etc/nginx/conf.d/default.conf

#RUN	chown -R www-data:www-data /etc/nginx

VOLUME	/var/www/html
WORKDIR	/var/www/html

EXPOSE	443

COPY	./tools/nginx-entrypoint.sh /usr/local/bin/nginx-entrypoint.sh
RUN		chmod +x /usr/local/bin/nginx-entrypoint.sh

RUN 	openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 \
		-keyout /etc/ssl/private/wordpress.key \
		-out /etc/ssl/certs/wordpress.crt \
		-subj "/C=FI/ST=Uusimaa/L=Helsinki/O=Hive/CN=${DOMAIN_NAME}"

ENTRYPOINT	["nginx-entrypoint.sh"]
