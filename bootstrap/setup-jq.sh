#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

JQ_VERSION=1.5 # https://stedolan.github.io/jq/download/

try
(
	throwErrors

	echo "Install binary"
	cd /tmp
	wget https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64
	chmod +x jq-linux64
	mv jq-linux64 /usr/bin/jq

)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
