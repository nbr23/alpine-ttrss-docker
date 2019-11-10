FROM alpine:edge
RUN apk update
RUN apk upgrade
RUN apk add nginx php7 php7-fpm php7-mysqli php7-json php7-iconv php7-dom php7-curl php7-pcntl php7-posix php7-gd php7-pdo_mysql php7-session php7-mbstring php7-intl php7-fileinfo git mariadb-client

WORKDIR /var/www/
RUN rm -rf localhost && \
    git clone https://tt-rss.org/git/tt-rss.git tt-rss

WORKDIR /var/www/tt-rss

# If you want to restore from a backup:
COPY backup.sql /tmp/ttrss.sql
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/php-fpm.conf /etc/php7/php-fpm.conf
COPY conf/config.php /var/www/tt-rss/config.php
COPY bin/start_ttrss /usr/bin/start_ttrss
RUN adduser ttrss --disabled-password

EXPOSE 80

CMD ["start_ttrss"]
