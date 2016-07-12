#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

LETS_ENCRYPT_PATH=/opt/letsencrypt

try
(
	throwErrors

	echo "Download latest Certbot client"
	rm -rf ${LETS_ENCRYPT_PATH}
	mkdir -p ${LETS_ENCRYPT_PATH}
	cd ${LETS_ENCRYPT_PATH}
	wget -nv https://dl.eff.org/certbot-auto
	chmod a+x certbot-auto

	echo "Link executable in environment"
	ln -sf ${LETS_ENCRYPT_PATH}/certbot-auto /usr/bin/certbot-auto
)
catch || {
case $ex_code in
	*)
		echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
		throw $ex_code
	;;
esac
}
