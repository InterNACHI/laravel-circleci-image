FROM circleci/php:7.3-stretch-node-browsers

MAINTAINER Chris Morrell

USER root

RUN apt-get update \
	&& apt-get install \
		zlib1g-dev \
		libsqlite3-dev \
		libpng-dev \
		libzip-dev \
		libjpeg62-turbo-dev \
		libfreetype6-dev \
		mysql-client \
	&& docker-php-ext-install -j$(nproc) exif \
	&& docker-php-ext-install -j$(nproc) pdo_mysql \
	&& docker-php-ext-install -j$(nproc) bcmath \
	&& docker-php-ext-configure opcache \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-configure gd \
		--with-gd \
		--with-png-dir \
		--with-jpeg-dir \
		--with-freetype-dir \
		--with-zlib-dir \
	&& docker-php-ext-install -j$(nproc) gd \
	&& rm /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

COPY "optimizations.ini" "/usr/local/etc/php/conf.d/optimizations.ini"

USER circleci
