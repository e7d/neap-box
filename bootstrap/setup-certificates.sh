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

	echo "Generate self-signed certificate"
	if [ ! -f /etc/ssl/localcerts/self.pem ]; then
		mkdir -p /etc/ssl/localcerts
		openssl req -new -x509 -subj "/CN=`uname -n`/O=Neap/C=US" -days 3650 -nodes -out /etc/ssl/localcerts/self.pem -keyout /etc/ssl/localcerts/self.key >/tmp/openssl.log 2>&1
		cat /tmp/openssl.log
		chmod -cR 600 /etc/ssl/localcerts/self.*
	else
		echo "skipped..."
	fi

	echo "Copy dhparam file"
	if [ ! -f /etc/ssl/private/dhparam.pem ]; then
		cp /vagrant/resources/ssl/private/dhparam.pem /etc/ssl/private
	else
		echo "skipped..."
	fi
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
