FROM php:fpm-alpine 

MAINTAINER bcouto@gmail.com

RUN apk add --no-cache sudo

RUN docker-php-ext-install pdo pdo_mysql 

RUN rm -rf /var/cache/apk/*

RUN sed -i "s/user = www-data/user = apache/" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i "s/group = www-data/group = apache/" /usr/local/etc/php-fpm.d/www.conf

COPY ./rconfig-3.6.7 /home/rconfig
 
RUN adduser -D -H apache apache && \
    find /home/rconfig -type d | xargs chmod 775 && \
    find /home/rconfig -type f | xargs chmod 664 && \
    chown apache.apache -R /home/rconfig

RUN echo "apache ALL = (ALL) NOPASSWD: /usr/bin/crontab, /usr/bin/zip, /bin/chmod, /bin/chown, /usr/bin/whoami, /usr/bin/wc, /usr/bin/tail, /bin/rm" >> /etc/sudoers && \
    echo "Defaults:apache !requiretty" >> /etc/sudoers

RUN chmod u+s /usr/bin/crontab

RUN mkdir -p /home/rconfig/nginx/conf.d
COPY nginx.default.conf /home/rconfig/nginx/conf.d/default.conf

VOLUME ["/home/rconfig", "/home/rconfig/nginx/conf.d/", "/var/spool/cron/"]

WORKDIR /home/rconfig
