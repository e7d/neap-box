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

	echo "Add 'deb-multimedia' repository to Aptitude"
	cd /tmp
	wget -nv http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb
	dpkg -i deb-multimedia-keyring_2016.8.1_all.deb
	echo "deb http://www.deb-multimedia.org jessie main non-free"   >/etc/apt/sources.list.d/ffmpeg.list
	echo "deb http://www.deb-multimedia.org jessie-backports main" >>/etc/apt/sources.list.d/ffmpeg.list
	apt-get -yq update

	echo "Install package"
	apt-get -yq install ffmpeg
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
