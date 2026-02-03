FROM php:8.1-apache

# 1. Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    libpng-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

# 2. Use JSON syntax [ "source", "destination" ] for paths with spaces
COPY ["pet shop management.zip", "/tmp/"]

# 3. Use quotes inside the shell command for unzip
RUN unzip "/tmp/pet shop management.zip" -d /var/www/html/ \
    && rm "/tmp/pet shop management.zip" \
    && chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html
EXPOSE 80
