FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    unzip \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

# Use JSON syntax for the filename with spaces
COPY ["pet shop management.zip", "/tmp/"]

# Unzip, move files if they are in a subfolder, and fix permissions
RUN unzip "/tmp/pet shop management.zip" -d /var/www/html/ \
    && rm "/tmp/pet shop management.zip" \
    && chmod -R 755 /var/www/html \
    && chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html
EXPOSE 80
