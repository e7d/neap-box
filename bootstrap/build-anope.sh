#!/bin/bash

ANOPE_VERSION=2.0.2 # https://github.com/anope/anope/releases/

try
(
    throwErrors

    echo "Download dependencies"
    apt-get -y -q install cmake

    echo "Download sources"
    cd ${SRC}
    if [ ! -f ${SRC}/anope-${ANOPE_VERSION}-source.tar.gz ]; then
        wget https://github.com/anope/anope/releases/download/${ANOPE_VERSION}/anope-${ANOPE_VERSION}-source.tar.gz
        tar xzvf anope-${ANOPE_VERSION}-source.tar.gz
    else
        echo "skipped..."
    fi
    cd anope*

    echo "Build Anope"
    rm -fr /etc/anope/
    cp -R ${DIR}/bootstrap/resources/anope/src/* .
    ./Config -nointro -quick
    cd build
    make
    make install

    echo "Copy service script"
    cp ${DIR}/bootstrap/resources/anope/bin/anope /etc/init.d

    echo "Fix permissions"
    chown -cR irc:irc /etc/anope
    chown -c irc:irc /etc/init.d/anope
    chmod -c +x /etc/init.d/anope

    echo "Register service script"
    systemctl enable anope
    systemctl unmask anope
    systemctl daemon-reload

    echo "Remove temporary files"
    rm -fr ${SRC}/anope*
)
catch || {
    case $ex_code in
        *)
            echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
            throw $ex_code
        ;;
    esac
}
