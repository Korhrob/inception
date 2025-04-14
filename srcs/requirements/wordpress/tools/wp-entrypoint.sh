#!/bin/sh

set -e

until mysqladmin ping -h"$DB_HOST" --silent; do
    sleep 1
done

if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."

	if echo "$WP_ADMIN_USER" | grep -i 'admin'; then
		echo "Error: Admin username cannot contain 'admin' or 'administrator'"
		exit 1
	fi

	wp config create \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PASSWORD" \
		--dbhost="$DB_HOST"

    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    wp user create "$WP_GUEST_USER" "$WP_GUEST_EMAIL" \
        --user_pass="$WP_GUEST_PASS" \
        --role=editor \
        --allow-root
else
    echo "WordPress is already installed."
fi

echo "Starting PHP..."
exec php-fpm7.4 -F
