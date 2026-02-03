# Use a specific version to ensure environment stability
FROM php:8.1-apache

# 1. Install system dependencies and clean up cache to keep image small
RUN apt-get update && apt-get install -y \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Enable Apache rewrite module (common for PHP apps)
RUN a2enmod rewrite

# 3. Copy your application code
# Assuming your zip file is in the root of your GitHub repo
COPY "pet shop management.zip" /tmp/

# 4. Extract and set permissions
RUN unzip /tmp/"pet shop management.zip" -d /var/www/html/ \
    && rm /tmp/"pet shop management.zip" \
    && chown -R www-data:www-data /var/www/html

# 5. Set the working directory
WORKDIR /var/www/html

# 6. Expose port 80 for the web server
EXPOSE 80

# Apache runs in the foreground by default in this base image
