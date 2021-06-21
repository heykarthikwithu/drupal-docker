#!/bin/sh

export NGINX_USER=${NGINX_USER:-'nobody'}
export NGINX_CONF=${NGINX_CONF:-'/etc/nginx/nginx.conf'}
export PHP_USER=${PHP_USER:-'www-data'}
export PHP_GROUP=${PHP_GROUP:-'www-data'}
export PHP_MODE=${PHP_MODE:-'0660'}
export PHP_FPM_CONF=${PHP_FPM_CONF:-'/etc/php7/php-fpm.d/www.conf'}
envsubst '${NGINX_USER} ${NGINX_CONF} ${PHP_USER} ${PHP_GROUP} ${PHP_MODE} ${PHP_FPM_CONF}' < /tmp/nginx.conf.tpl > $NGINX_CONF
envsubst '${NGINX_USER} ${NGINX_CONF} ${PHP_USER} ${PHP_GROUP} ${PHP_MODE} ${PHP_FPM_CONF}' < /tmp/php-fpm.conf.tpl > $PHP_FPM_CONF

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
