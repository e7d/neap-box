#!/bin/bash

UNREAL_VERSION=3.4-latest # https://www.unrealircd.org/download

try
(
    throwErrors

    echo "Set bash access to 'irc' account"
    chsh -s /bin/bash irc

    echo "Download UnrealIRCd sources"
    cd /usr/src
    if [ ! -f ${SRC}/unreal*.tar.gz ]; then
        wget --no-check-certificate --trust-server-names https://www.unrealircd.org/downloads/Unreal${UNREAL_VERSION}.tar.gz
        tar xzvf unreal*.tar.gz
    else
        echo "skipped..."
    fi
    cd unreal*

    echo "Build UnrealIRCd"
    rm -fr /etc/unrealircd/
    cp -R ${DIR}/bootstrap/resources/unrealircd/src/* .
    chmod +x config.settings
    ./config.settings
    ./Config -nointro -quick
    make
    make install

    echo "Copy UnrealIRCd service script"
    cp ${DIR}/bootstrap/resources/unrealircd/bin/unrealircd /etc/init.d

    echo "Fix UnrealIRCd permissions"
    chown -cR irc.irc /etc/unrealircd
    chown -c irc.irc /etc/init.d/unrealircd
    chmod -c +x /etc/init.d/unrealircd

    echo "Register UnrealIRCd service script"
    systemctl enable unrealircd
    systemctl unmask unrealircd
    systemctl daemon-reload

    echo "Remove temporary files"
    rm -fr /usr/src/unrealircd*
)
catch || {
    case $ex_code in
        *)
            echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
            throw $ex_code
        ;;
    esac
}
