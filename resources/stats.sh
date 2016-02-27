#!/bin/bash

CATEGORY=$1
ACTION=$2
VALUE=$3
if [ -z $VALUE ]; then
	VALUE=0
fi

ANALYTICS=UA-66226242-6
DOMAIN="box.neap.io"
UUID=$(cat /proc/sys/kernel/random/uuid)
USER_AGENT='Neap Box'
EPOCH=$(date +%s)

curl "http://www.google-analytics.com/collect" \
	--data-urlencode "v=1" \
	--data-urlencode "ds=box" \
	--data-urlencode "t=event" \
	--data-urlencode "ec=${CATEGORY}" \
	--data-urlencode "ea=${ACTION}" \
	--data-urlencode "ev=${VALUE}" \
	--data-urlencode "tid=${ANALYTICS}" \
	--data-urlencode "cid=${UUID}" \
	--data-urlencode "dl=http://${DOMAIN}/" \
	--data-urlencode "z=${EPOCH}" \
	--user-agent "${USER_AGENT}" \
	--compressed \
	--silent \
	--output /dev/null
