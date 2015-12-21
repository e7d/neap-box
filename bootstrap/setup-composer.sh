#!/bin/bash

try
(
    throwErrors

    echo "Install binary"
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
)
catch || {
    case $ex_code in
        *)
            echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
            throw $ex_code
        ;;
    esac
}
