# Use the official PHP 8.2 image with Apache
FROM php:8.2-apache

# Install system dependencies & PHP extensions required by CakePHP
RUN apt-get update && apt-get install -y libicu-dev libpng-dev libzip-dev zip \
    && docker-php-ext-install intl pdo_mysql gd zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy the CakePHP application into the /var/www/html directory
COPY . /var/www/html/

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Run Composer install to install PHP dependencies
RUN composer install --no-interaction --no-ansi --no-dev --prefer-dist --optimize-autoloader
