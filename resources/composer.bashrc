#!/bin/bash

function try()
{
	[[ $- = *e* ]]; SAVED_OPT_E=$?
	set +e
}

function catch()
{
	export ex_code=$?
	(( $SAVED_OPT_E )) && set +e
	return $ex_code
}

function composer() {
	# Trap interrupts (like Ctrl+C) to restore Xdebug correctly
	trap cleanup INT

	function cleanup() {
		if [ -f /tmp/xdebug-composer.ini ]; then
			sudo mv /tmp/xdebug-composer.ini /etc/php/7.1/cli/conf.d/20-xdebug.ini
		fi
	}

	try
	(
		set -e

		COMPOSER="$(which composer)" || { echo "Could not find composer in path" >&2 ; return 1 ; }
		if [ -f /etc/php/7.1/cli/conf.d/20-xdebug.ini ]; then
			sudo mv /etc/php/7.1/cli/conf.d/20-xdebug.ini /tmp/xdebug-composer.ini
		fi
		$COMPOSER "$@"
		STATUS=$?
		cleanup
		return $STATUS
	)
	catch || {
		cleanup
		return $ex_code
	}

	trap - INT
}
