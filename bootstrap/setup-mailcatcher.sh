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

	echo "Update Ruby environment"
	gem update --system

	echo "Install gem"
	gem install mailcatcher

	echo "Copy service script"
	cp /vagrant/resources/mailcatcher/bin/mailcatcher /etc/init.d

	echo "Fix permissions"
	chown -c mail:mail /etc/init.d/mailcatcher
	chmod -c +x /etc/init.d/mailcatcher

	echo "Register service script"
	systemctl unmask mailcatcher
	systemctl enable mailcatcher
	systemctl daemon-reload
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
