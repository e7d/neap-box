#!/bin/bash

CUSTOM=0
for ARG in "$@"
do
case $ARG in
	--halt)
		HELP="--help"
		shift
	;;
	-H|--halt)
		HALT="--halt"
		shift
	;;
	-h|-P|--poweroff)
		POWEROFF="--poweroff"
		shift
	;;
	-r|--reboot)
		REBOOT="--reboot"
		shift
	;;
	-k)
		WARNINGS="-k"
		shift
	;;
	--no-wall)
		NOWALL="--no-wall"
		shift
	;;
	-c)
		CANCEL="-c"
		shift
	;;
	*)
		((CUSTOM++))
		case $CUSTOM in
			1)
				TIME=$ARG
				shift
			;;
			2)
				WALL=$ARG
				shift
			;;
		esac
	;;
esac
done

if [ ! -z $HALT ] || [ ! -z $POWEROFF ] || [ ! -z $REBOOT ] ; then
	if [ -z $TIME ] ; then
		TIME="now"
		SLEEP=5
		echo "shutdown will occur in $SLEEP seconds"
		sleep $SLEEP
	fi
fi

COMMAND="/sbin/shutdown ${HELP} ${HALT} ${POWEROFF} ${REBOOT} ${WARNINGS} ${NOWALL} ${CANCEL} ${TIME} ${WALL}"
eval $COMMAND
sync
