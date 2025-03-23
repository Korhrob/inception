FROM	debian:bullseye-slim

RUN		apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Remove Default Files
RUN		rm -rf /etc/nginx/sites-enabled/default
RUN		rm -rf /var/www/html/index.nginx-debian.html

COPY	./conf/nginx.conf /etc/nginx/nginx.conf
COPY	./conf/default.conf /etc/nginx/conf.d/default.conf

# Test File
COPY	./conf/index.html /var/www/html/index.html

RUN		chown -R www-data:www-data /etc/nginx

VOLUME	/var/www/html
WORKDIR	/var/www/html

#RUN	mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

EXPOSE	80

CMD	["nginx", "-g", "daemon off;"]
