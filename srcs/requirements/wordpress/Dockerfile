FROM	debian:bullseye-slim

RUN	apt-get update && apt-get install -y \
	php7.4-fpm \
	php7.4-gd \
	php7.4-mysql \
	php7.4-mbstring \
	php7.4-xml \
	php7.4-curl \
	curl \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN	mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

RUN	curl -o /tmp/latest.tar.gz https://wordpress.org/latest.tar.gz && \
	tar -xvzf /tmp/latest.tar.gz -C /var/www/html && \
	rm /tmp/latest.tar.gz

#RUN		chown -R www-data:www-data /var/www/html/wordpress

COPY	./conf/wp-config.php /var/www/html/wordpress/wp-config.php
RUN		chown www-data:www-data /var/www/html/wordpress/wp-config.php

EXPOSE	9000

RUN		mkdir -p /run/php && chown -R www-data:www-data /run/php
RUN		sed -i 's|^listen =.*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

COPY	./tools/wp-entrypoint.sh /usr/local/bin/wp-entrypoint.sh
RUN		chmod +x /usr/local/bin/wp-entrypoint.sh

ENTRYPOINT	["wp-entrypoint.sh"]
#CMD	["php-fpm7.4", "-F"]
