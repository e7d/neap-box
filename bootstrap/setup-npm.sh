#!/bin/sh

echo "Install NPM package manager"
cd /tmp
curl -sL https://deb.nodesource.com/setup_5.x | bash -
apt-get install -y nodejs
npm install -g npm@latest

echo "Install Yeoman"
npm install -g yo

echo "Install Bower"
npm install -g bower

echo "Install Grunt"
npm install -g grunt
npm install -g grunt-cli

echo "Install Jasmine"
npm install -g jasmine

echo "Install Karma"
npm install -g karma
