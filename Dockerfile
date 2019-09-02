FROM circleci/php:7.3-cli-stretch

MAINTAINER Chris Morrell

USER root

RUN apt-get update \
	&& apt-get install apt-transport-https \
	&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
	&& curl -sL https://deb.nodesource.com/setup_12.x | bash - \
	&& apt-get update \
	&& apt-get install \
		build-essential \
		zlib1g-dev \
		libsqlite3-dev \
		libpng-dev \
		libjpeg62-turbo-dev \
		libfreetype6-dev \
		mysql-client \
		nodejs \
		yarn \
	&& docker-php-ext-install -j$(nproc) exif \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install -j$(nproc) intl \
	&& docker-php-ext-install -j$(nproc) zip \
	&& docker-php-ext-install -j$(nproc) pdo_mysql \
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
