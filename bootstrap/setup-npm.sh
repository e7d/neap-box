#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

try
(
	throwErrors

	echo "Install NPM package manager"
	cd /tmp
	curl -sL https://deb.nodesource.com/setup_5.x | bash -
	apt-get install -y -q nodejs
	npm install -g npm@latest
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
