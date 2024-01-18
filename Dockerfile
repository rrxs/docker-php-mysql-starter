FROM php:7.2-apache 

ENV TZ="America/Recife"

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo "date.timezone=$TZ" >> /usr/local/etc/php/conf.d/default.ini
RUN echo $TZ > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod expires

RUN apt-get update

RUN apt-get install -y \
    libmcrypt-dev \
    zlib1g-dev \
    libxml2-dev \
    graphviz \
    libzip-dev \
    libonig-dev \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev

#ENV APACHE_DOCUMENT_ROOT=/var/www/html
#RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
#RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl

RUN docker-php-ext-install mysqli

RUN docker-php-ext-configure gd \
    --with-gd \
    --with-webp-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib-dir \
    --with-xpm-dir \
    --with-freetype-dir

RUN docker-php-ext-install gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pecl install xdebug; \
docker-php-ext-enable xdebug; \
#echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini;

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data
RUN service apache2 restart
WORKDIR /var/www/html
