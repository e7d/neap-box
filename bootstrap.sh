#!/bin/sh

# Start stopwatch
BEGIN=$(date +%s)

# Store execution directory
DIR=`dirname $0`

# Load dependencies
. ${DIR}/bootstrap/resources/colors.sh

# This script needs admin rights
echo_cyan Check admin rights
if [ 0 != $(id -u) ]; then
    echo_error "This script must be run as root!"
    exit 1
fi
echo_success "OK"

echo_cyan "Prepare Debian environment"
${DIR}/bootstrap/prepare-env.sh

echo_cyan "Setup ffmpeg"
${DIR}/bootstrap/setup-ffmpeg.sh

echo_cyan "Build OpenSSL"
echo_warning "Skipped, as long as OpenSSL 1.0.2d is breaking nginx 1.9.* build"
sleep 5
#${DIR}/bootstrap/build-openssl.sh

echo_cyan "Generate certificates"
${DIR}/bootstrap/generate-certificates.sh

echo_cyan "Build nginx"
${DIR}/bootstrap/build-nginx.sh

echo_cyan "Setup PHP"
${DIR}/bootstrap/setup-php.sh

echo_cyan "Setup PostgresQL"
${DIR}/bootstrap/setup-postgresql.sh

echo_cyan "Build Unreal"
${DIR}/bootstrap/build-unreal.sh

echo_cyan "Build Anope"
${DIR}/bootstrap/build-anope.sh

echo_cyan "Clean up"
${DIR}/bootstrap/cleanup.sh

echo_cyan "Zero disk"
${DIR}/bootstrap/zerodisk.sh

NOW=$(date +%s)
DIFF=$(($NOW - $BEGIN))
MINS=$(($DIFF / 60))
SECS=$(($DIFF % 60))
echo_info "Bootstrap lasted $MINS mins and $SECS secs"

exit 0
