#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

OPENSSL_VERSION=1.0.2e # http://www.linuxfromscratch.org/blfs/view/svn/postlfs/openssl.html

try
(
	throwErrors

	echo "Build dependencies"
	apt-get -y -q install build-essential libpcre3-dev libpcre++-dev \
	  zlib1g-dev libcurl4-openssl-dev libssl-dev

	echo "Download source code"
	cd /usr/src
	wget https://openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
	tar -xvzf openssl-${OPENSSL_VERSION}.tar.gz

	echo "Build binaries"
	cd /usr/src/openssl-${OPENSSL_VERSION}
	./config --prefix=/usr \
	         --openssldir=/etc/ssl \
	         --libdir=lib \
	         shared \
	         zlib-dynamic &&
	make

	echo "Install binaries"
	make install_sw
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
