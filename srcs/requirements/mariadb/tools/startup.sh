#!/bin/bash
set -e

# Start MariaDB in the background
mysqld &

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to start..."
while ! mysqladmin ping -hlocalhost --silent; do
    sleep 1
done

# Execute SQL commands directly
echo "Executing SQL commands..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Keep the container running
wait