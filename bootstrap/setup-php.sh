#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

try
(
	throwErrors

	echo "Add 'dotdeb' repository to Aptitude"
	cd /tmp
	wget --quiet -O - https://www.dotdeb.org/dotdeb.gpg | apt-key add -
	echo "deb http://packages.dotdeb.org jessie all" >/etc/apt/sources.list.d/dotdeb.list
	echo "deb-src http://packages.dotdeb.org jessie all" >>/etc/apt/sources.list.d/dotdeb.list
	apt-get -y -q update

	echo "Install packages"
	apt-get -y -q install php7.0 php7.0-cli php7.0-common php7.0-curl php7.0-dev php7.0-fpm php7.0-gd php7.0-intl php7.0-json php7.0-opcache php7.0-pgsql php7.0-sqlite3

	echo "Disable OPcache"
	sed -i '/;opcache.enable=0/c\opcache.enable=0' /etc/php/7.0/cli/php.ini
	sed -i '/;opcache.enable=0/c\opcache.enable=0' /etc/php/7.0/fpm/php.ini

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
