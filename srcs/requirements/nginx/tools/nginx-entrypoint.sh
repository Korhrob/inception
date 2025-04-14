#!/bin/sh

set -e

echo "Waiting for WordPress to be ready..."
until curl -s -f http://localhost/wp-login.php > /dev/null; do
    sleep 1
done

sed "s|__DOMAIN_NAME__|${DOMAIN_NAME}|g" \
	/etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf

echo "Starting NGINX..."
nginx -g "daemon off;"
