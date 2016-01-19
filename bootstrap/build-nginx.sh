#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

NGINX_VERSION=1.9.9 # http://nginx.org/en/download.html
NGINX_RTMP_VERSION=1.1.7 # https://github.com/arut/nginx-rtmp-module/releases
OPENSSL_VERSION=1.0.2e # http://www.linuxfromscratch.org/blfs/view/svn/postlfs/openssl.html

try
(
	throwErrors

	echo "Install nginx environment"
	apt-get -y -q install nginx-common

	echo "Download source code"
	cd /usr/src
	if [ ! -f /usr/src/nginx-${NGINX_VERSION}.tar.gz ]; then
		wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
		tar -zxvf nginx-${NGINX_VERSION}.tar.gz
	else
		echo "skipped..."
	fi

	echo "Download OpenSSL source code"
	cd /usr/src
	wget https://openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
	tar -xvzf openssl-${OPENSSL_VERSION}.tar.gz

	echo "Download nginx-rtmp-module source code"
	cd /usr/src
	if [ ! -d /usr/src/nginx-rtmp-module-${NGINX_RTMP_VERSION} ]; then
		# use a fork from https://github.com/arut/nginx-rtmp-module.git
		wget https://github.com/arut/nginx-rtmp-module/archive/v${NGINX_RTMP_VERSION}.tar.gz -O nginx-rtmp-module-${NGINX_RTMP_VERSION}.tar.gz
		tar -zxvf nginx-rtmp-module-${NGINX_RTMP_VERSION}.tar.gz
	else
		echo "skipped..."
	fi

	echo "Build binaries"
	cd /usr/src/nginx-${NGINX_VERSION}
	./configure --prefix=/var/www \
	            --sbin-path=/usr/sbin/nginx \
	            --conf-path=/etc/nginx/nginx.conf \
	            --pid-path=/var/run/nginx.pid \
	            --error-log-path=/var/log/nginx/error.log \
	            --http-log-path=/var/log/nginx/access.log \
	            --with-file-aio \
	            --with-http_ssl_module \
		    --with-openssl=/usr/src/openssl-${OPENSSL_VERSION} \
	            --with-http_v2_module \
	            --with-http_realip_module \
	            --with-http_addition_module \
	            --with-http_sub_module \
	            --with-http_dav_module \
	            --with-http_flv_module \
	            --with-http_mp4_module \
	            --with-http_gunzip_module \
	            --with-http_gzip_static_module \
	            --with-http_random_index_module \
	            --with-http_secure_link_module \
	            --with-http_stub_status_module \
	            --with-ipv6 \
	            --with-mail \
	            --with-mail_ssl_module \
	            --add-module=/usr/src/nginx-rtmp-module-${NGINX_RTMP_VERSION} &&
	make

	echo "Enable service binaries"
	systemctl unmask nginx.service
	systemctl enable nginx.service

	echo "Stop service"
	service nginx stop

	echo "Install newly built binaries"
	make install

	echo "Prepare environment for first start"
	mkdir -p /var/www
	cp -R html /var/www
	mkdir -p /var/log/nginx

	echo "Fix permissions"
	chown -cR www-data:www-data /var/www
	chown -cR www-data:www-data /var/log/nginx

	echo "Restart service"
	service nginx start
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
