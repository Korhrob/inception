#!/bin/sh

set -e

until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    sleep 1
done

if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."

	if echo "$WORDPRESS_ADMIN_USER" | grep -i 'admin'; then
		echo "Error: Admin username cannot contain 'admin' or 'administrator'"
		exit 1
	fi

    wp core install \
        --url="$WORDPRESS_URL" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    wp user create "$WP_SECOND_USER" "$WP_SECOND_USER_EMAIL" \
        --user_pass="$WP_SECOND_USER_PASSWORD" \
        --role=editor \
        --allow-root
else
    echo "WordPress is already installed."
fi

echo "Starting PHP..."
exec php-fpm7.4 -F
