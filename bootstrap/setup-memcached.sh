#!/bin/bash

try
(
    throwErrors

    echo "Install dependency packages"
    apt-get install -y -q libmemcached-dev

    echo "Download sources"
    cd ${SRC}
    git clone https://github.com/php-memcached-dev/php-memcached.git

    echo "Build library"
    cd php-memcached
    git checkout php7
    phpize
    ./configure --disable-memcached-sasl
    make
    sudo make install

    echo "Write configuration file"
    echo '; configuration for php memcached module' >/etc/php/mods-available/memcached.ini
    echo '; priority=20' >>/etc/php/mods-available/memcached.ini
    echo 'extension=memcached.so' >>/etc/php/mods-available/memcached.ini

    echo "Link configuration file to PHP"
    ln -s /etc/php/mods-available/memcached.ini /etc/php/7.0/fpm/conf.d/20-memcached.ini
    ln -s /etc/php/mods-available/memcached.ini /etc/php/7.0/cli/conf.d/20-memcached.ini

    echo "Restart PHP-FPM service"
    service php7.0-fpm restart

    echo "Remove temporary files"
    rm -fr /usr/src/php-memcached
)
catch || {
case $ex_code in
    *)
        echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
        throw $ex_code
    ;;
esac
}
