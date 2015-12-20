#!/bin/bash

try
(
    throwErrors

    echo "Install PostgreSQL"
    apt-get -y -q install postgresql postgresql-contrib
)
catch || {
    case $ex_code in
        *)
            echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
            throw $ex_code
        ;;
    esac
}
