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

	echo "Add 'sury' repository to Aptitude"
	wget --quiet -O - https://packages.sury.org/php/apt.gpg | apt-key add -
	echo "deb https://packages.sury.org/php jessie main" >/etc/apt/sources.list.d/sury.list
	echo "deb-src https://packages.sury.org/php jessie main" >>/etc/apt/sources.list.d/sury.list
	apt-get -y -q update

	echo "Install packages"
	apt-get -y -q install php7.1 php7.1-cli php7.1-common php7.1-curl php7.1-dev php7.1-fpm php7.1-gd \
	                      php7.1-intl php7.1-json php7.1-mbstring php7.1-opcache php7.1-pgsql php7.1-sqlite3 \
	                      php7.1-xml php7.1-zip php-xdebug

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
