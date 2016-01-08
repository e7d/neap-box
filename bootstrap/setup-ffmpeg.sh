#!/bin/bash

try
(
	throwErrors

	echo "Add 'deb-multimedia' repository to Aptitude"
	cd /tmp
	wget http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2015.6.1_all.deb
	dpkg -i deb-multimedia-keyring_2015.6.1_all.deb
	echo "deb http://www.deb-multimedia.org jessie main non-free" >/etc/apt/sources.list.d/ffmpeg.list
	apt-get -y -q update

	echo "Install package"
	apt-get -y -q install ffmpeg
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
