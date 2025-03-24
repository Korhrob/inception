#!/bin/sh

set -e

echo "Setting up wordpress filepermissions..."

chown www-data:www-data /var/www/html/wordpress/wp-config.php
chown -R www-data:www-data /var/www/html/wordpress

echo "Starting PHP"
exec php-fpm4.3 -F
