#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

PHPREDIS_VERSION=3.1.2 # https://github.com/phpredis/phpredis/releases

try
(
	throwErrors

	echo "Download sources"
	cd /usr/src
	wget -nv https://github.com/phpredis/phpredis/archive/${PHPREDIS_VERSION}.tar.gz -O phpredis-${PHPREDIS_VERSION}.tar.gz
	tar -zxvf phpredis-${PHPREDIS_VERSION}.tar.gz

	echo "Build library"
	cd phpredis-${PHPREDIS_VERSION}
	phpize
	./configure
	make -j$(nproc)
	make install

	echo "Write mod configuration file"
	echo '; configuration for php redis module' >/etc/php/7.1/mods-available/redis.ini
	echo '; priority=20' >>/etc/php/7.1/mods-available/redis.ini
	echo 'extension=redis.so' >>/etc/php/7.1/mods-available/redis.ini

	echo "Link configuration file to PHP"
	ln -sf /etc/php/7.1/mods-available/redis.ini /etc/php/7.1/fpm/conf.d/20-redis.ini
	ln -sf /etc/php/7.1/mods-available/redis.ini /etc/php/7.1/cli/conf.d/20-redis.ini

	echo "Write PHP configuration files"
	echo >>/etc/php/7.1/cli/php.ini
	echo '[redis]' >>/etc/php/7.1/cli/php.ini
	echo 'session.save_handler = redis' >>/etc/php/7.1/cli/php.ini
	echo 'session.save_path = "tcp://127.0.0.1:6379" ' >>/etc/php/7.1/cli/php.ini
	echo >>/etc/php/7.1/fpm/php.ini
	echo '[redis]' >>/etc/php/7.1/fpm/php.ini
	echo 'session.save_handler = redis' >>/etc/php/7.1/fpm/php.ini
	echo 'session.save_path = "tcp://127.0.0.1:6379"' >>/etc/php/7.1/fpm/php.ini

	echo "Restart service"
	service redis restart

	echo "Restart PHP-FPM service"
	service php7.1-fpm restart
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
