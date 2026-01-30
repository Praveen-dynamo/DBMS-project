FROM php:8.1-apache
# Install mysql extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql
# Copy all project files into the web root
COPY . /var/www/html/
# Ensure permissions are correct
RUN chown -R www-data:www-data /var/www/html
