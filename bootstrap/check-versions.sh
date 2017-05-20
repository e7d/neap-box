#!/bin/bash

. /vagrant/resources/colors.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

NEAPBOX=$(cat /etc/neap_box_version)
DEBIAN=$(cat /etc/debian_version)
VBOXGUESTADDITIONS=$(echo `modinfo vboxguest` | sed 's/.*\bversion: \([^ ]*\).*/\1/')
CERTBOT=$(cat /opt/letsencrypt/certbot-auto | grep LE_AUTO_VERSION= | sed 's/.*LE_AUTO_VERSION="\(.*\)"/\1/')
JQ=$(echo `jq -V` | sed 's/.*jq-\(.*\)/\1/')
POSTGRESQL=$(echo `psql -V` | sed 's/psql (PostgreSQL) \(.*\)/\1/')
REDIS=$(echo `redis-server -v` | sed 's/Redis server v=\([^ ]*\).*/\1/')
MAILCATCHER=$(echo `gem list | grep mailcatcher` | sed -r 's/mailcatcher \((.*)\)/\1/')
NGINX=$(echo `nginx -v 2>&1` | sed 's/.*nginx\/\(.*\)/\1/')
OPENSSL=$(echo `nginx -V 2>&1` | sed 's/.*openssl-\([^ ]*\).*/\1/')
NGINX_RTMP=$(echo `nginx -V 2>&1` | sed 's/.*nginx-rtmp-module-\(.*\)/\1/')
PHP=$(echo `php -v` | sed 's/PHP \([^-]*\).*/\1/')
PHPFPM=$(echo `php-fpm7.1 -v` | sed 's/PHP \([^-]*\).*/\1/')
PHPREDIS=$(echo `php -i | grep 'Redis Version'` | sed 's/Redis Version => \(.*\)/\1/')
XDEBUG=$(echo `php -v` | sed 's/.*Xdebug v\([^,]*\).*/\1/')
COMPOSER=$(echo `composer 2>&1` | sed 's/.*Composer version \([^ ]*\).*/\1/')
NODEJS=$(echo `node -v` | sed 's/v\([^,]*\).*/\1/')
NPM=$(npm -v)
NEWMAN=$(newman --version)
FFMPEG=$(echo `ffmpeg -version` | sed 's/.*ffmpeg version \([^ ]*\).*/\1/')
UNREALIRCD=$(echo `sudo -u irc /etc/unrealircd/bin/unrealircd -v 2>&1` | sed 's/.*UnrealIRCd-\([^ ]*\).*/\1/')
ANOPE=$(echo `/etc/anope/bin/services -v` | sed 's/Anope-\([^ ]*\).*/\1/')

echo 'Neap Box: '$NEAPBOX
echo '`-- Debian: '$DEBIAN
echo '  +-- VirtualBox Guest Additions: '$VBOXGUESTADDITIONS
echo '  +-- Lets Encrypt Certbot: '$CERTBOT
echo '  +-- jq: '$JQ
echo '  +-- PostgreSQL: '$POSTGRESQL
echo '  +-- Redis: '$REDIS
echo '  +-- MailCatcher: '$MAILCATCHER
echo '  +-- nginx: '$NGINX
echo '  | +-- OpenSSL: '$OPENSSL
echo '  | `-- nginx-rtmp-module: '$NGINX_RTMP
echo '  +-- PHP: '$PHP
echo '  | +-- PHP-FPM: '$PHPFPM
echo '  | +-- PhpRedis: '$PHPREDIS
echo '  | +-- Xdebug: '$XDEBUG
echo '  | `-- Composer: '$COMPOSER
echo '  +-- NodeJS: '$NODEJS
echo '  | +-- NPM: '$NPM
echo '  | `-- Newman: '$NEWMAN
echo '  +-- FFmpeg: '$FFMPEG
echo '  `-- UnrealIRCd: '$UNREALIRCD
echo '    `-- Anope: '$ANOPE
