#!/bin/sh

set -e

echo "Waiting for WordPress to be ready..."
until curl -s -f http://localhost/wp-login.php > /dev/null; do
    sleep 1
done

echo "Starting NGINX..."
nginx -g "daemon off;"
