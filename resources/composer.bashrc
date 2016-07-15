function composer() {
	DATE=$(date +%s%N)
	COMPOSER="$(which composer)" || { echo "Could not find composer in path" >&2 ; return 1 ; } &&
	sudo mv /etc/php/7.0/cli/conf.d/20-xdebug.ini /tmp/xdebug-$DATE.ini || { echo ; } &&
	$COMPOSER "$@"
	STATUS=$?
	sudo mv /tmp/xdebug-$DATE.ini /etc/php/7.0/cli/conf.d/20-xdebug.ini || { echo ; } &&
	return $STATUS
}
