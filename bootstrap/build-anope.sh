#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

ANOPE_VERSION=2.0.2 # https://github.com/anope/anope/releases/

try
(
	throwErrors

	echo "Download sources"
	cd /usr/src
	if [ ! -f /usr/src/anope-${ANOPE_VERSION}-source.tar.gz ]; then
		wget https://github.com/anope/anope/releases/download/${ANOPE_VERSION}/anope-${ANOPE_VERSION}-source.tar.gz
		tar xzvf anope-${ANOPE_VERSION}-source.tar.gz
	else
		echo "skipped..."
	fi
	cd anope*

	echo "Build Anope"
	rm -fr /etc/anope/
	cp -R /vagrant/resources/anope/src/* .
	./Config -nointro -quick
	cd build
	make
	make install

	echo "Copy service script"
	cp /vagrant/resources/anope/bin/anope /etc/init.d

	echo "Fix permissions"
	chown -cR irc:irc /etc/anope
	chown -c irc:irc /etc/init.d/anope
	chmod -c +x /etc/init.d/anope

	echo "Register service script"
	systemctl enable anope
	systemctl unmask anope
	systemctl daemon-reload

	echo "Remove temporary files"
	rm -fr /usr/src/anope*
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
