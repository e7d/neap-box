#!/bin/bash

DIR=$(dirname `which $0`)
echo /vagrant

exit 0

try
(
	throwErrors

	echo "Install NPM package manager"
	cd /tmp
	curl -sL https://deb.nodesource.com/setup_5.x | bash -
	apt-get install -y nodejs
	npm install -g npm@latest

	echo "Install JS Hint"
	npm install -g jshint

	echo "Install Yeoman"
	npm install -g yo

	echo "Install Bower"
	npm install -g bower

	echo "Install Grunt"
	npm install -g grunt-cli

	echo "Install Jasmine"
	npm install -g jasmine

	echo "Install Karma"
	npm install -g karma-cli
)
catch || {
case $ex_code in
	*)
		echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
		throw $ex_code
	;;
esac
