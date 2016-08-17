#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

XDEBUG_TAG=XDEBUG_2_4_1 # https://github.com/xdebug/xdebug/releases
XDEBUG_VERSION=2.4.1

try
(
	throwErrors

	echo "Download sources"
	cd /usr/src
	wget -nv https://github.com/xdebug/xdebug/archive/${XDEBUG_TAG}.tar.gz -O xdebug-${XDEBUG_VERSION}.tar.gz
	tar -zxvf xdebug-${XDEBUG_VERSION}.tar.gz

	echo "Build library"
	cd xdebug-${XDEBUG_TAG}
	phpize
	./configure --enable-xdebug
	make -j$(nproc)
	make install

	echo "Write mod configuration file"
	echo '; configuration for php xdebug module' >/etc/php/7.0/mods-available/xdebug.ini
	echo '; priority=20' >>/etc/php/7.0/mods-available/xdebug.ini
	echo 'zend_extension=xdebug.so' >>/etc/php/7.0/mods-available/xdebug.ini

	echo "Link configuration file to PHP"
	ln -sf /etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/fpm/conf.d/20-xdebug.ini
	ln -sf /etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/cli/conf.d/20-xdebug.ini

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
rm -rf /usr/src/xdebug
