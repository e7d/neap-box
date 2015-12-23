#!/bin/bash

try
(
    throwErrors

    echo "Download source code"
    mkdir -p /etc/letsencrypt/src
    cd /etc/letsencrypt/src
    git clone https://github.com/letsencrypt/letsencrypt
    cd letsencrypt

    echo "First run"
    ./letsencrypt-auto
)
catch || {
case $ex_code in
    *)
        echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
        throw $ex_code
    ;;
esac
}
