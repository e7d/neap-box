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

	echo "Install binary"
	curl -sS https://getcomposer.org/installer | php
	mv composer.phar /usr/local/bin/composer
	composer self-update

	echo "Install global packages"
	composer global require phpunit/phpunit

	echo "Add vendor binaries to the path"
	echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> /home/vagrant/.bashrc
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
