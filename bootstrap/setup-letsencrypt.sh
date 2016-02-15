#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

LETS_ENCRYPT_SRC=/etc/letsencrypt/src

try
(
	throwErrors

	echo "Download source code"
	mkdir -p ${LETS_ENCRYPT_SRC}
	git clone https://github.com/letsencrypt/letsencrypt ${LETS_ENCRYPT_SRC}
	cd ${LETS_ENCRYPT_SRC}

	echo "Link executable"
	ln -sf ${LETS_ENCRYPT_SRC}/letsencrypt-auto /usr/bin/letsencrypt
)
catch || {
case $ex_code in
	*)
		echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
		throw $ex_code
	;;
esac
}
