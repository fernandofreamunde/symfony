FROM php:8.1-fpm-alpine

RUN echo "Setting Timezone" \
    && apk add --no-cache tzdata \
    && mkdir /var/log/supervisor \
    && mkdir /run/supervisor \
    && cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime \
    && echo "Europe/Amsterdam" > /etc/timezone \
    && apk del tzdata

RUN echo "Installing dependencies" \
    && apk update \
    && apk add --no-cache \
    && apk add curl-dev \
    && apk add libpng-dev \
    && apk add bzip2-dev \
    && apk add libxml2-dev \
    && apk add libzip-dev \
    && apk add openssl \
    && apk add postgresql-dev \
    && apk add libpq \
    && apk add zip \
    && apk add unzip \
    && apk add libsodium \
    && apk add zlib-dev \
    && apk add supervisor

RUN echo "Installing extensions" \
    && docker-php-ext-install pdo pdo_pgsql pgsql curl intl gd xml zip bz2 opcache sockets \
    && apk add --no-cache $PHPIZE_DEPS

EXPOSE 9000
CMD ["php-fpm"]
