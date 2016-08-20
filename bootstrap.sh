#!/bin/bash

# Start stopwatch
export BEGIN=$(date +%s)

# Load dependencies
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

	/vagrant/resources/analytics.sh -t=event -ec=bootstrap -ea=start

	echox "${text_cyan}Info:${text_reset} Bootstrap started at $(date +'%Y-%m-%d %H:%M:%S %Z')"

	echox "${text_cyan}Prepare Debian environment"
	/vagrant/bootstrap/prepare-env.sh

	echox "${text_cyan}Setup Let's Encrypt Certbot"
	/vagrant/bootstrap/setup-certbot.sh

	echox "${text_cyan}Setup certificates"
	/vagrant/bootstrap/setup-certificates.sh

	echox "${text_cyan}Setup jq"
	/vagrant/bootstrap/setup-jq.sh

	echox "${text_cyan}Setup PostgresQL"
	/vagrant/bootstrap/setup-postgresql.sh

	echox "${text_cyan}Build Redis"
	/vagrant/bootstrap/build-redis.sh

	echox "${text_cyan}Setup Mailcatcher"
	/vagrant/bootstrap/setup-mailcatcher.sh

	echox "${text_cyan}Build nginx"
	/vagrant/bootstrap/build-nginx.sh

	echox "${text_cyan}Setup PHP"
	/vagrant/bootstrap/setup-php.sh

	echox "${text_cyan}Setup PhpRedis"
	/vagrant/bootstrap/setup-phpredis.sh

	echox "${text_cyan}Setup Composer"
	/vagrant/bootstrap/setup-composer.sh

	echox "${text_cyan}Setup NPM"
	/vagrant/bootstrap/setup-npm.sh

	echox "${text_cyan}Setup Newman"
	/vagrant/bootstrap/setup-newman.sh

	echox "${text_cyan}Setup ffmpeg"
	/vagrant/bootstrap/setup-ffmpeg.sh

	echox "${text_cyan}Build Unreal"
	/vagrant/bootstrap/build-unreal.sh

	echox "${text_cyan}Build Anope"
	/vagrant/bootstrap/build-anope.sh

	echox "${text_cyan}Clean up"
	/vagrant/bootstrap/cleanup.sh

	echox "${text_cyan}Zero disk"
	/vagrant/bootstrap/zerodisk.sh

	echox "${text_cyan}Installed versions:${text_reset}"
	/vagrant/bootstrap/check-versions.sh

	NOW=$(date +%s)
	DIFF=$(echo "$NOW-$BEGIN" | bc)
	MINS=$(echo "$DIFF/60" | bc)
	SECS=$(echo "$DIFF%60" | bc)
	echox "${text_cyan}Info:${text_reset} Bootstrap ended at $(date +'%Y-%m-%d %H:%M:%S %Z')"
	echox "${text_cyan}Info:${text_reset} Bootstrap lasted $MINS mins and $SECS secs"

	/vagrant/resources/analytics.sh -t=event -ec=bootstrap -ea=success
	/vagrant/resources/analytics.sh -t=timing -utc=bootstrap -utv=duration -utt=$DIFF"000"
)
catch || {
	/vagrant/resources/analytics.sh -t=event -ec=bootstrap -ea=fail

	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} Bootstrap was aborted!"
			throw $ex_code
		;;
	esac
}
