#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

try
(
	throwErrors

	echo "Download sources"
	cd /usr/src
	git clone https://github.com/xdebug/xdebug.git

	echo "Build library"
	cd xdebug
	phpize
	./configure --enable-xdebug
	make
	make install

	echo "Write mod configuration file"
	echo '; configuration for php xdebug module' >/etc/php/mods-available/xdebug.ini
	echo '; priority=20' >>/etc/php/mods-available/xdebug.ini
	echo 'zend_extension=xdebug.so' >>/etc/php/mods-available/xdebug.ini

	echo "Link configuration file to PHP"
	ln -sf /etc/php/mods-available/xdebug.ini /etc/php/7.0/fpm/conf.d/20-xdebug.ini
	ln -sf /etc/php/mods-available/xdebug.ini /etc/php/7.0/cli/conf.d/20-xdebug.ini

	echo "Restart PHP-FPM service"
	service php7.0-fpm restart

	echo "Remove temporary files"
	rm -fr /usr/src/xdebug
)
catch || {
case $ex_code in
	*)
		echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
		throw $ex_code
	;;
esac
}
