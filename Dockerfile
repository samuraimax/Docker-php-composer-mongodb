FROM php:7.4-fpm
# ARG user=kazha
# ARG uid=1000
RUN apt-get update
RUN apt-get install -y zlib1g-dev libzip-dev
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libgd-dev
RUN apt-get install -y nginx cron libonig-dev
RUN docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/
RUN docker-php-ext-install iconv pdo json
RUN docker-php-ext-install gd
RUN docker-php-ext-install zip
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install mysqli pdo pdo_mysql
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN apt-get install -y --no-install-recommends openssl libssl-dev libcurl4-openssl-dev supervisor
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /run/supervisor
RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN pecl install mongodb
RUN echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/ext-mongodb.ini
# RUN useradd -G www-data,root -u $uid -d /home/$user $user
# RUN mkdir -p /home/$user/.composer && \
#     chown -R $user:$user /home/$user
COPY ./start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]

WORKDIR /var/www

# CMD ["php-fpm"]
# CMD ["/start.sh"]

# Copy local supervisord.conf to the conf.d directory
#COPY --chown=root:root supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]

# USER $user