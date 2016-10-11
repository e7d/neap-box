#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

REDIS_VERSION=3.2.4 # http://redis.io/download

try
(
	throwErrors

	echo "Download source code"
	cd /usr/src
	if [ ! -f /usr/src/redis-${REDIS_VERSION}.tar.gz ]; then
		wget -nv http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz
		tar -zxvf redis-${REDIS_VERSION}.tar.gz
	else
		echo "skipped..."
	fi

	echo "Build binaries"
	cd /usr/src/redis-${REDIS_VERSION}
	make -j$(nproc)

	echo "Install newly built binaries"
	make install clean

	echo "Add redis user"
	ignoreErrors
	id -u "redis" >/dev/null 2>&1
	if [ $? -eq 1 ]; then
		useradd -s /bin/false -d /var/lib/redis -M -U redis
	fi
	throwErrors

	echo "Prepare folders"
	mkdir -p /etc/redis
	mkdir -p /var/redis/
	mkdir -p /var/log/redis/

	echo "Prepare configuration"
	cp redis.conf /etc/redis/redis.conf.default
	cp /vagrant/resources/redis/conf/6379.conf /etc/redis/6379.conf

	echo "Copy service script"
	cp /vagrant/resources/redis/bin/redis /etc/init.d/redis

	echo "Fix permissions"
	chown -c redis:redis /etc/init.d/redis
	chmod -c +x /etc/init.d/redis
	chown -cR redis:redis /etc/redis
	chown -cR redis:redis /var/log/redis
	chown -cR redis:redis /var/redis

	echo "Register service script"
	systemctl unmask redis
	systemctl enable redis
	systemctl daemon-reload

	echo "Start service"
	service redis start
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
