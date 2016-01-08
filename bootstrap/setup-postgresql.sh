#!/bin/bash

try
(
    throwErrors

    echo "Add repository to Aptitude"
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >/etc/apt/sources.list.d/pgdg.list
    apt-get -y -q update

    echo "Install packages"
    apt-get -y -q install postgresql-9.5 postgresql-client-9.5 postgresql-client-common postgresql-common postgresql-contrib-9.5
)
catch || {
    case $ex_code in
        *)
            echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
            throw $ex_code
        ;;
    esac
}
