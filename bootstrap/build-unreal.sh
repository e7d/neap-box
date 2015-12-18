#!/bin/sh

DIR=`dirname $0`

echo "Set bash access to 'irc' account"
chsh -s /bin/bash irc

echo "Download UnrealIRCd sources"
cd /usr/src
wget --no-check-certificate --trust-server-names https://www.unrealircd.org/downloads/Unreal3.4-latest.tar.gz
tar xzvf unreal*.tar.gz
cd unreal*

echo "Build UnrealIRCd"
rm -fr /etc/unrealircd/
cp -R ${DIR}/resources/unrealircd/src/* .
chmod +x config.settings
./config.settings
./Config -nointro -quick
make
make install

echo "Copy UnrealIRCd service script"
cp ${DIR}/resources/unrealircd/bin/unrealircd /etc/init.d
systemctl daemon-reload

echo "Fix UnrealIRCd permissions"
chown -cR irc.irc /etc/unrealircd
chown -c irc.irc /etc/init.d/unrealircd
chmod -c +x /etc/init.d/unrealircd

echo "Remove temporary files"
rm -fr /usr/src/unrealircd*
