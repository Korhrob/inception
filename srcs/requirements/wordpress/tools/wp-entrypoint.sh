#!/bin/sh

set -e

#until nc -z mariadb 3306; do
#  echo "Waiting for MariaDB to be ready..."
sleep 10
#done

echo "Setting up wordpress filepermissions..."

chown www-data:www-data /var/www/html/wordpress/wp-config.php
chown -R www-data:www-data /var/www/html/wordpress

echo "Starting PHP..."
exec php-fpm7.4 -F

