#!/bin/sh

DIR=`dirname $0`

echo "Install PostgreSQL"
apt-get -y -q install postgresql postgresql-contrib

exit 0
