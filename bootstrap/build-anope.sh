#!/bin/sh

DIR=`dirname $0`

echo "Download Anope dependencies"
apt-get -y -q install cmake

echo "Download Anope sources"
cd /usr/src
wget https://github.com/anope/anope/releases/download/2.0.2/anope-2.0.2-source.tar.gz
tar xzvf anope-2.0.2-source.tar.gz
cd anope*

echo "Build Anope"
rm -fr /etc/anope/
cp -R ${DIR}/resources/anope/src/* .
./Config -nointro -quick
cd build
make
make install

echo "Copy Anope service script"
cp ${DIR}/resources/anope/bin/anope /etc/init.d
systemctl daemon-reload

echo "Fix Anope permissions"
chown -cR irc:irc /etc/anope
chown -c irc:irc /etc/init.d/anope
chmod -c +x /etc/init.d/anope

echo "Remove temporary files"
rm -fr /usr/src/anope*
