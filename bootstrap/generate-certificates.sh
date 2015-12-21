#!/bin/bash

try
(
    throwErrors

    echo "Generate self-signed certificate"
    if [ ! -f /etc/ssl/localcerts/self.pem ]; then
        mkdir -p /etc/ssl/localcerts
        openssl req -new -x509 -subj "/CN=`uname -n`/O=Neap/C=US" -days 3650 -nodes -out /etc/ssl/localcerts/self.pem -keyout /etc/ssl/localcerts/self.key
        chmod -cR 600 /etc/ssl/localcerts/self.*
    else
        echo "skipped..."
    fi

    echo "Generate dhparam file"
    if [ ! -f /etc/ssl/private/dhparam.pem ]; then
        openssl dhparam -out /etc/ssl/private/dhparam.pem 2048
    else
        echo "skipped..."
    fi
)
catch || {
    case $ex_code in
        *)
            echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
            throw $ex_code
        ;;
    esac
}
