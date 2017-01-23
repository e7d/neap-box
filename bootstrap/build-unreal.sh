#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

UNREAL_VERSION=4.0.10 # https://www.unrealircd.org/download/4.0/

try
(
	throwErrors

	echo "Set bash access to 'irc' account"
	chsh -s /bin/bash irc

	echo "Download sources"
	cd /usr/src
	if [ ! -f /usr/src/unreal*.tar.gz ]; then
		wget -nv --no-check-certificate --trust-server-names https://www.unrealircd.org/unrealircd4/unrealircd-${UNREAL_VERSION}.tar.gz
		tar -zxvf unrealircd-*.tar.gz
	else
		echo "skipped..."
	fi
	cd unreal*

	echo "Build binaries"
	rm -rf /etc/unrealircd/
	cp -R /vagrant/resources/unrealircd/src/* .
	chmod +x config.settings
	./config.settings
	./Config -nointro -quick
	make -j$(nproc)
	make install

	echo "Copy service script"
	cp /vagrant/resources/unrealircd/bin/unrealircd /etc/init.d

	echo "Fix permissions"
	chown -cR irc.irc /etc/unrealircd
	chown -c irc.irc /etc/init.d/unrealircd
	chmod -c +x /etc/init.d/unrealircd

	echo "Register service script"
	systemctl unmask unrealircd
	systemctl enable unrealircd
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

echo "Remove temporary files"
rm -rf /usr/src/unreal*
