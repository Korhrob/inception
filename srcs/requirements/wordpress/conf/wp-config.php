<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'robert');
define('DB_PASSWORD', '59dfe0d2e2%');
define('DB_HOST', 'mariadb');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

$table_prefix  = 'wp_';

if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/wordpress/');

require_once(ABSPATH . 'wp-settings.php');
