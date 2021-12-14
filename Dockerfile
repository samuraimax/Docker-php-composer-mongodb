FROM php:7.4-fpm
RUN apt-get update
RUN apt-get install -y zlib1g-dev libzip-dev
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libgd-dev
RUN docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN docker-php-ext-install mysqli pdo pdo_mysql
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN apt-get install -y --no-install-recommends openssl libssl-dev libcurl4-openssl-dev
RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN pecl install mongodb
RUN echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/ext-mongodb.ini
WORKDIR /var/www
