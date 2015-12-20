#!/bin/bash

# Start stopwatch
export BEGIN=$(date +%s)

# Store execution directory
export DIR=$(dirname `which $0`)
export SRC=/usr/src

# Load dependencies
. ${DIR}/bootstrap/resources/colors.sh
. ${DIR}/bootstrap/resources/trycatch.sh

# This script needs admin rights
echox "${text_cyan}Check admin rights"
if [ 0 != $(id -u) ]; then
    echo_error "This script must be run as root!"
    exit 1
fi
echox "${text_green}OK"

try
(
    throwErrors

    echox "${text_cyan}Prepare Debian environment"
    ${DIR}/bootstrap/prepare-env.sh

    echox "${text_cyan}Setup ffmpeg"
    ${DIR}/bootstrap/setup-ffmpeg.sh

    echox "${text_cyan}Build OpenSSL"
    echox "${text_yellow}Warning:${text_reset} Skipped, as long as OpenSSL 1.0.2d is breaking nginx 1.9.* build"
    sleep 5
    #${DIR}/bootstrap/build-openssl.sh

    echox "${text_cyan}Generate certificates"
    ${DIR}/bootstrap/generate-certificates.sh

    echox "${text_cyan}Build nginx"
    ${DIR}/bootstrap/build-nginx.sh

    echox "${text_cyan}Setup PHP"
    ${DIR}/bootstrap/setup-php.sh

    echox "${text_cyan}Setup PostgresQL"
    ${DIR}/bootstrap/setup-postgresql.sh

    echox "${text_cyan}Build Unreal"
    ${DIR}/bootstrap/build-unreal.sh

    echox "${text_cyan}Build Anope"
    ${DIR}/bootstrap/build-anope.sh

    echox "${text_cyan}Clean up"
    ${DIR}/bootstrap/cleanup.sh

    echox "${text_cyan}Zero disk"
    ${DIR}/bootstrap/zerodisk.sh

    NOW=$(date +%s)
    DIFF=$(echo "$NOW-$BEGIN" | bc)
    MINS=$(echo "$DIFF/60" | bc)
    SECS=$(echo "$DIFF%60" | bc)
    echox "${text_cyan}Info:${text_reset} Bootstrap lasted $MINS mins and $SECS secs"
)
catch || {
    case $ex_code in
        *)
            echox "${text_red}Error:${text_reset} Bootstrap was aborted!"
            throw $ex_code
        ;;
    esac
}
