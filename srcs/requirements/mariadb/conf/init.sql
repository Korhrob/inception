-- Create the WordPress database
CREATE DATABASE IF NOT EXISTS wordpress DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create a new WordPress user and set their password
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Grant the user full access to the WordPress database
GRANT ALL PRIVILEGES ON wordpress.* TO '${MYSQL_USER}'@'localhost' WITH GRANT OPTION;

-- Flush privileges to apply changes
FLUSH PRIVILEGES;
