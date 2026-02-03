FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    unzip \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

# 1. Copy the zip using JSON syntax
COPY ["pet shop management.zip", "/tmp/"]

# 2. Extract, move contents to root, and fix permissions
RUN unzip "/tmp/pet shop management.zip" -d /tmp/extracted/ \
    && cp -rn /tmp/extracted/*/. /var/www/html/ || cp -rn /tmp/extracted/. /var/www/html/ \
    && rm -rf /tmp/extracted "/tmp/pet shop management.zip" \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

WORKDIR /var/www/html
EXPOSE 80
