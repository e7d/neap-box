#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

REDIS_VERSION=3.0.7 # http://redis.io/download

try
(
	throwErrors

	echo "Download source code"
	cd /usr/src
	if [ ! -f /usr/src/redis-${REDIS_VERSION}.tar.gz ]; then
		wget http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz
		tar -zxvf redis-${REDIS_VERSION}.tar.gz
	else
		echo "skipped..."
	fi

	echo "Build binaries"
	cd /usr/src/redis-${REDIS_VERSION}
	make

	echo "Install newly built binaries"
	make install clean

	echo "Add redis user"
	useradd -s /bin/false -d /var/lib/redis -M redis

	echo "Prepare folders"
	mkdir -p /var/run/redis/ &&
	chown redis:redis /var/run/redis
	mkdir -p /var/log/redis/ &&
	chown -cR redis:redis /var/log/redis/
	mkdir -p /etc/redis
	chown -cR redis:redis /etc/redis

	echo "Prepare configuration"
	cp redis.conf /etc/redis/redis.conf.default
	cp /vagrant/resources/redis/conf/6379.conf /etc/redis/6379.conf
	chown -cR redis:redis /etc/redis

	echo "Copy service script"
	cp /vagrant/resources/redis/bin/redis /etc/init.d/redis

	echo "Fix permissions"
	chown -cR redis.redis /etc/redis
	chown -c redis.redis /etc/init.d/redis
	chmod -c +x /etc/init.d/redis

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
