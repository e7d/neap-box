#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

try
(
	throwErrors

	echo "Install apt dependencies"
	apt-get install -y -q libsqlite3-dev ruby-dev

	echo "Update Ruby environment"
	gem update --system

	echo "Install gem"
	gem install mailcatcher
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
