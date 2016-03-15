#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

LETS_ENCRYPT_SRC=/etc/letsencrypt/src
LETS_ENCRYPT_TAG=v0.4.0

try
(
	throwErrors

	echo "Download source code"
	rm -rf ${LETS_ENCRYPT_SRC}
	git clone https://github.com/letsencrypt/letsencrypt ${LETS_ENCRYPT_SRC}
	cd ${LETS_ENCRYPT_SRC}
	git checkout tags/${LETS_ENCRYPT_TAG}

	echo "Link executable"
	ln -sf ${LETS_ENCRYPT_SRC}/letsencrypt-auto /usr/bin/letsencrypt

	echo "Prepare first time launch"
	/usr/bin/letsencrypt --version 2>&1 /dev/null

	echo "Remove useless git files"
	rm -rf ${LETS_ENCRYPT_SRC}/.git/
)
catch || {
case $ex_code in
	*)
		echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
		throw $ex_code
	;;
esac
}
