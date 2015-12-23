#!/bin/bash

try
(
    throwErrors

    LETS_ENCRYPT_SRC=/etc/letsencrypt/src

    echo "Download source code"
    mkdir -p ${LETS_ENCRYPT_SRC}
    git clone https://github.com/letsencrypt/letsencrypt ${LETS_ENCRYPT_SRC}
    cd ${LETS_ENCRYPT_SRC}

    echo "Install dependencies"
    ./bootstrap/install-deps.sh
    ./bootstrap/dev/venv.sh

    echo "Link executable"
    ln -s ${LETS_ENCRYPT_SRC}/venv/bin/letsencrypt /usr/bin/letsencrypt
)
catch || {
case $ex_code in
    *)
        echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
        throw $ex_code
    ;;
esac
}
