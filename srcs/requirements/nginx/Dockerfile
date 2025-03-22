FROM	debian:bullseye-slim

RUN	apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

RUN	rm -rf /etc/nginx/sites-enabled/default

COPY	./conf/nginx.conf /etc/nginx/nginx.conf
#COPY	./conf/default.conf /etc/nginx/conf.d/default.conf
RUN	chown -R www-data:www-data /etc/nginx

#RUN	mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

EXPOSE	80

CMD	["nginx", "-g", "daemon off;"]
