#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

PHPREDIS_VERSION=3.0.0 # https://github.com/phpredis/phpredis/releases

try
(
	throwErrors

	echo "Download sources"
	cd /usr/src
	wget https://github.com/phpredis/phpredis/archive/${PHPREDIS_VERSION}.tar.gz
	tar -zxvf phpredis-${PHPREDIS_VERSION}.tar.gz

	echo "Build library"
	cd phpredis-${PHP_REDIS_VERSION}
	phpize
	./configure
	make -j$(nproc)
	make install

	echo "Write mod configuration file"
	echo '; configuration for php redis module' >/etc/php/mods-available/redis.ini
	echo '; priority=20' >>/etc/php/mods-available/redis.ini
	echo 'extension=redis.so' >>/etc/php/mods-available/redis.ini

	echo "Link configuration file to PHP"
	ln -sf /etc/php/mods-available/redis.ini /etc/php/7.0/fpm/conf.d/20-redis.ini
	ln -sf /etc/php/mods-available/redis.ini /etc/php/7.0/cli/conf.d/20-redis.ini

	echo "Write PHP configuration files"
	echo >>/etc/php/7.0/cli/php.ini
	echo '[redis]' >>/etc/php/7.0/cli/php.ini
	echo 'session.save_handler = redis' >>/etc/php/7.0/cli/php.ini
	echo 'session.save_path = "tcp://127.0.0.1:6379" ' >>/etc/php/7.0/cli/php.ini
	echo >>/etc/php/7.0/fpm/php.ini
	echo '[redis]' >>/etc/php/7.0/fpm/php.ini
	echo 'session.save_handler = redis' >>/etc/php/7.0/fpm/php.ini
	echo 'session.save_path = "tcp://127.0.0.1:6379"' >>/etc/php/7.0/fpm/php.ini

	echo "Restart service"
	service redis restart

	echo "Restart PHP-FPM service"
	service php7.0-fpm restart
)
catch || {
case $ex_code in
	*)
		echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
		throw $ex_code
	;;
esac
}

echo "Remove temporary files"
rm -rf /usr/src/phpredis
