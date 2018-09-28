FROM wordpress:4.9.8-php7.2-apache

# MailCatcher
RUN apt-get update && apt-get install -y ruby ruby-dev rubygems libsqlite3-dev less
RUN gem install mailcatcher
ADD ./mailcatcher.ini $PHP_INI_DIR/conf.d/

# Xdebug
RUN pecl install xdebug-2.6.1 && docker-php-ext-enable xdebug
ADD ./xdebug.ini $PHP_INI_DIR/conf.d/

# wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY wordpress-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["wordpress-entrypoint.sh"]
CMD ["apache2-foreground"]