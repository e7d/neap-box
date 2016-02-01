#!/bin/bash

# Start stopwatch
export BEGIN=$(date +%s)

# Load dependencies
. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
echox "${text_cyan}Check admin rights"
if [ 0 != $(id -u) ]; then
	echo_error "This script must be run as root!"
	exit 1
fi
echox "${text_green}OK"

try
(
	throwErrors

	echox "${text_cyan}Prepare Debian environment"
	/vagrant/bootstrap/prepare-env.sh

	echox "${text_cyan}Setup ffmpeg"
	/vagrant/bootstrap/setup-ffmpeg.sh

	echox "${text_cyan}Setup PostgresQL"
	/vagrant/bootstrap/setup-postgresql.sh

	echox "${text_cyan}Setup Let's Encrypt"
	/vagrant/bootstrap/setup-letsencrypt.sh

	echox "${text_cyan}Generate certificates"
	/vagrant/bootstrap/generate-certificates.sh

	echox "${text_cyan}Build nginx"
	/vagrant/bootstrap/build-nginx.sh

	echox "${text_cyan}Setup PHP"
	/vagrant/bootstrap/setup-php.sh

	echox "${text_cyan}Setup Xdebug"
	/vagrant/bootstrap/setup-xdebug.sh

	echox "${text_cyan}Setup Memcached"
	/vagrant/bootstrap/setup-memcached.sh

	echox "${text_cyan}Setup Composer"
	/vagrant/bootstrap/setup-composer.sh

	echox "${text_cyan}Setup NPM"
	/vagrant/bootstrap/setup-npm.sh

	echox "${text_cyan}Build Unreal"
	/vagrant/bootstrap/build-unreal.sh

	echox "${text_cyan}Build Anope"
	/vagrant/bootstrap/build-anope.sh

	echox "${text_cyan}Clean up"
	/vagrant/bootstrap/cleanup.sh

	echox "${text_cyan}Zero disk"
	/vagrant/bootstrap/zerodisk.sh

	NOW=$(date +%s)
	DIFF=$(echo "$NOW-$BEGIN" | bc)
	MINS=$(echo "$DIFF/60" | bc)
	SECS=$(echo "$DIFF%60" | bc)
	echox "${text_cyan}Info:${text_reset} Bootstrap lasted $MINS mins and $SECS secs"

	echox "${text_cyan}Installed versions:${text_reset}"
	/vagrant/bootstrap/check-versions.sh
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} Bootstrap was aborted!"
			throw $ex_code
		;;
	esac
}
