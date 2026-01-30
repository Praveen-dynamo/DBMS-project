# Use a specific platform to fix the "exec format error"
FROM --platform=linux/amd64 php:8.1-apache

# Install unzip and PHP extensions for MySQL
RUN apt-get update && apt-get install -y unzip \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Copy the zip file into the container
COPY "pet shop management.zip" /tmp/

# Unzip to the web root and clean up
RUN unzip /tmp/"pet shop management.zip" -d /var/www/html/ \
    && rm /tmp/"pet shop management.zip" \
    && chown -R www-data:www-data /var/www/html
