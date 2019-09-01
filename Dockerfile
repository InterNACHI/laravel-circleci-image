FROM circleci/php:7.3-stretch-node-browsers

MAINTAINER Chris Morrell

RUN sudo -E apt-get install -y \
		zlib1g-dev \
		libsqlite3-dev \
		libpng-dev \
		libjpeg62-turbo-dev \
		mysql-client \
	&& sudo -E docker-php-ext-install -j$(nproc) exif \
	&& sudo -E docker-php-ext-configure intl \
	&& sudo -E docker-php-ext-install intl \
	&& sudo -E docker-php-ext-install zip \
	&& sudo -E docker-php-ext-install pdo_mysql \
	&& sudo -E docker-php-ext-configure gd \
		--with-gd \
		--with-png-dir=/usr/include/ \
		--with-jpeg-dir=/usr/include/ \
	&& sudo -E docker-php-ext-install gd \
	&& sudo -E php -r "copy('https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer', 'composer-setup.php');" \
	&& sudo -E php composer-setup.php \
	&& sudo -E php -r "unlink('composer-setup.php');" \
	&& sudo -E mv composer.phar /usr/local/bin/composer
