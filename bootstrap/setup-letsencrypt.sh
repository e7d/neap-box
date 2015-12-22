#!/bin/bash

try
(
    throwErrors

    echo "Download source code"
    cd ${SRC}
    git clone https://github.com/letsencrypt/letsencrypt
    cd letsencrypt

    echo "Install dependencies"
    ./bootstrap/install-deps.sh
    ./bootstrap/dev/venv.sh

    echo "Register binaries"
    source ./venv/bin/activate
)
catch || {
case $ex_code in
    *)
        echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
        throw $ex_code
    ;;
esac
}
