#!/bin/bash

NGINX_VERSION=1.8.0 # http://nginx.org/en/download.html

try
(
    throwErrors

    echo "Build dependencies"
    apt-get -y -q install build-essential libpcre3-dev libpcre++-dev zlib1g-dev libcurl4-openssl-dev libssl-dev nginx-common

    echo "Download source code"
    cd ${SRC}
    if [ ! -f ${SRC}/nginx-${NGINX_VERSION}.tar.gz ]; then
        wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
        tar -xvzf nginx-${NGINX_VERSION}.tar.gz
    else
        echo "skipped..."
    fi

    echo "Download nginx-rtmp-module source code"
    cd ${SRC}
    if [ ! -d ${SRC}/nginx-rtmp-module ]; then
        git clone --progress https://github.com/arut/nginx-rtmp-module.git
    else
        echo "skipped..."
    fi

    echo "Build binaries"
    cd ${SRC}/nginx-${NGINX_VERSION}
    ./configure --prefix=/var/www \
                --sbin-path=/usr/sbin/nginx \
                --conf-path=/etc/nginx/nginx.conf \
                --pid-path=/var/run/nginx.pid \
                --error-log-path=/var/log/nginx/error.log \
                --http-log-path=/var/log/nginx/access.log \
                --with-file-aio \
                --with-http_ssl_module \
                --with-http_spdy_module \
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
                --add-module=${SRC}/nginx-rtmp-module &&
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

    echo "Cleanup temporary files"
    rm -rf ${SRC}/nginx-${NGINX_VERSION}*
    rm -rf ${SRC}/nginx-rtmp-module*
)
catch || {
    case $ex_code in
        *)
            echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
            throw $ex_code
        ;;
    esac
}
