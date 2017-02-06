#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

try
(
	throwErrors

	echo "Add 'ondrej' repository to Aptitude"
	wget --quiet -O - https://packages.sury.org/php/apt.gpg | apt-key add -
	echo "deb https://packages.sury.org/php jessie all" >/etc/apt/sources.list.d/ondrej.list
	echo "deb-src https://packages.sury.org/php jessie all" >>/etc/apt/sources.list.d/ondrej.list
	apt-get -y -q update

	echo "Install packages"
	apt-get -y -q install php7.0 php7.0-cli php7.0-common php7.0-curl php7.0-dev php7.0-fpm php7.0-gd \
	                      php7.0-intl php7.0-json php7.0-mbstring php7.0-opcache php7.0-pgsql php7.0-sqlite3 \
	                      php7.0-xdebug php7.0-xml php7.0-zip

	echo "Remove unused additional packages"
	apt-get -y -q autoremove --purge php5-*

	echo "Disable OPcache"
	sed -i 's/;\?opcache.enable=.\+/opcache.enable=0/g' /etc/php/7.0/fpm/php.ini

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
