#!/bin/bash

/usr/local/bin/docker-entrypoint.sh apache2_

if [ -z "$WORDPRESS_HOST" ]; then
    WORDPRESS_HOST=localhost
fi

if [ -z "$WORDPRESS_PORT" ]; then
    WORDPRESS_PORT=8080
fi

cd /var/www/html
wp core install --url=$WORDPRESS_HOST:$WORDPRESS_PORT --title=Test --admin_user=admin --admin_password=admin --admin_email=info@example.com --skip-email --allow-root
wp language core install ja --allow-root
wp site switch-language ja --allow-root
wp plugin install wp-multibyte-patch --activate --allow-root

exec "$@"