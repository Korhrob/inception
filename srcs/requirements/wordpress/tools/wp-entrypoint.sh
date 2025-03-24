#!/bin/sh

set -e

echo "Starting PHP..."
exec php-fpm7.4 -F

