FROM	debian:bullseye-slim

RUN		apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*
RUN		rm -rf /etc/nginx/sites-enabled/default
RUN		rm -rf /var/www/html/index.nginx-debian.html

COPY	./conf/nginx.conf /etc/nginx/nginx.conf
COPY	./conf/default.conf /etc/nginx/conf.d/default.conf

RUN		chown -R www-data:www-data /etc/nginx

VOLUME	/var/www/html
WORKDIR	/var/www/html

EXPOSE	8080

CMD	["nginx", "-g", "daemon off;"]
