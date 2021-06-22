FROM alpine:3.14

RUN apk add php7 php7-fpm php7-opcache php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype php7-session \
    php7-pear php7-cgi php7-common php7-pdo php7-pdo_mysql php7-gettext php7-bcmath php7-xmlrpc \
    php7-zip php7-imap php7-simplexml php7-pecl-xdebug \
    php7-mbstring php7-tokenizer php7-xmlwriter php7-gd \
    bash git openssh supervisor curl imagemagick gettext

RUN apk add nginx nginx-mod-http-headers-more

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx.conf /tmp/nginx.conf.tpl
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY config/fpm-pool.conf /tmp/php-fpm.conf.tpl
COPY config/php.ini /etc/php7/php.ini
COPY config/php-custom.ini /etc/php7/conf.d/fpm/custom.ini
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/nginx-selfsigned.crt /etc/nginx/certs/ssl.crt
COPY config/nginx-selfsigned.key /etc/nginx/certs/ssl.key
COPY config/dhparam.pem /etc/nginx/certs/dhparam.pem
RUN mkdir /etc/nginx/snippets
COPY config/self-signed.conf /etc/nginx/snippets/
COPY config/ssl-params.conf /etc/nginx/snippets/
RUN pecl config-set php_ini /etc/php7/php.ini

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=2.1.3
RUN composer --version
RUN php -r "readfile('https://github.com/drush-ops/drush/releases/download/10.5.0/drush.phar');" > drush
RUN chmod +x drush && mv drush /usr/bin/

RUN mkdir -p /var/www/html
WORKDIR /var/www/html
RUN chmod u+w /var/www/html/

#RUN cd /var/www/html
#RUN COMPOSER_MEMORY_LIMIT=-1 composer install -d /var/www/html/

RUN chown -R nobody:nobody /var/log
VOLUME /var/log
#RUN chown -R nobody:nobody /var/www/html/web/sites/default/files
#VOLUME /var/www/html/web/sites/default/files
#RUN chown nobody:nobody /var/www/html/private

EXPOSE 443

CMD ["sh", "docker-utils/web/docker-run.sh"]
