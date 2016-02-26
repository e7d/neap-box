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
	mkdir -p /etc/ssl/localcerts
	rm -f /etc/ssl/localcerts/self.pem
	openssl req -new -x509 -subj "/CN=`uname -n`/O=Neap/C=US" -days 3650 -nodes -out /etc/ssl/localcerts/self.pem -keyout /etc/ssl/localcerts/self.key >/tmp/openssl.log 2>&1
	cat /tmp/openssl.log
	chmod -cR 600 /etc/ssl/localcerts/self.*

	echo "Copy dhparam file"
	cp /vagrant/resources/ssl/private/dhparam.pem /etc/ssl/private
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
