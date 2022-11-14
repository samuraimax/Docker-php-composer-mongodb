#!/bin/bash

php-fpm -D
nginx -g 'daemon off;'
# service cron start
# service supervisor start


# supervisorctl reread

# supervisorctl update

# /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

