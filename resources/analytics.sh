#!/bin/bash

. /vagrant/resources/colors.sh

ANALYTICS=UA-66226242-7
DOMAIN="box.neap.io"
if [ ! -f ~/.analytics ]; then
	cat /proc/sys/kernel/random/uuid > ~/.analytics
fi
UUID=$(cat ~/.analytics)
USER_AGENT='Neap Box'
EPOCH=$(date +%s)

for arg in "$@"; do
case $arg in
	-ea=*|--event-action=*)
		EVENT_ACTION="${arg#*=}"
		shift
	;;
	-ec=*|--event-category=*)
		EVENT_CATEGORY="${arg#*=}"
		shift
	;;
	-ev=*|--event-value=*)
		EVENT_CATEGORY="${arg#*=}"
		shift
	;;
	-h|--help)
		HELP=1
	;;
	-t=*|--hit-type=*)
		HIT_TYPE="${arg#*=}"
		shift
	;;
	-utc=*|--user-timing-category=*)
		USER_TIMING_CATEGORY="${arg#*=}"
		shift
	;;
	-utt=*|--user-timing-time=*)
		USER_TIMING_TIME="${arg#*=}"
		shift
	;;
	-utv=*|--user-timing-variable=*)
		USER_TIMING_VARIABLE="${arg#*=}"
		shift
	;;
esac
shift
done

function display_help()
{
	echo "Usage: analytics.sh [OPTION]..."
	echo
	echo "  -ea, --event-action            Specifies the event action"
	echo "  -ec, --event-category          Specifies the event category"
	echo "  -ev, --event-value             Specifies the event value"
	echo "  -h, --help                     Displays this help"
	echo "  -t, --hit-type                 Specifies the hit type"
	echo "  -utc, --user-timing-category   Specifies the event action"
	echo "  -utt, --user-timing-time       Specifies the event category"
	echo "  -utv, --user-timing-variable   Specifies the event value"
	echo
	exit 0
}

if [ -z $HIT_TYPE ]; then
	echox "${text_red}Error:${text_reset} A hit type must be set"
	echo
	display_help
fi

# Build Query
QUERY=" --data-urlencode \"v=1\""
QUERY="${QUERY} --data-urlencode \"tid=${ANALYTICS}\""
QUERY="${QUERY} --data-urlencode \"cid=${UUID}\""
QUERY="${QUERY} --data-urlencode \"dl=http://${DOMAIN}/bootstrap\""
QUERY="${QUERY} --data-urlencode \"ds=box\""
QUERY="${QUERY} --data-urlencode \"t=${HIT_TYPE}\""
if [[ "event" == ${HIT_TYPE} ]]; then
	QUERY="${QUERY} --data-urlencode \"ec=${EVENT_CATEGORY}\""
	QUERY="${QUERY} --data-urlencode \"ea=${EVENT_ACTION}\""
	if [ ! -z ${EVENT_VALUE} ]; then
		QUERY="${QUERY} --data-urlencode \"ev=${EVENT_VALUE}\""
	fi
elif [[ "timing" == ${HIT_TYPE} ]]; then
	QUERY="${QUERY} --data-urlencode \"utc=${USER_TIMING_CATEGORY}\""
	QUERY="${QUERY} --data-urlencode \"utv=${USER_TIMING_VARIABLE}\""
	QUERY="${QUERY} --data-urlencode \"utt=${USER_TIMING_TIME}\""
else
	echox "${text_red}Error:${text_reset} The hit type is invalid: ${HIT_TYPE}"
	echo "  It should be: event, timing"
	echo
	display_help
fi
QUERY="${QUERY} --data-urlencode \"z=${EPOCH}\""
QUERY="${QUERY} --user-agent \"${USER_AGENT}\""
QUERY="${QUERY} --compressed --silent --output /dev/null"
QUERY="\"http://www.google-analytics.com/collect\" ${QUERY}"
export toto=$QUERY

if [ ! -z $HELP ]; then
	display_help
fi

eval curl $QUERY
