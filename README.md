# Neap Box

A Vagrant box for [Neap](https://github.com/e7d/neap) development.

## Read me first

This project aims to give you the necessary tools to build yourself the Neap Box.  
**Note:** If you only intend to use the Neap Box, you will never have to build it yourself! Instead, get it from:
* [GitHub releases](https://github.com/e7d/neap-box/releases)
* [Atlas by HashiCorp](https://atlas.hashicorp.com/e7d/boxes/neap-box)

## About

**Version:** 1.4.0-dev  
**Web:** Coming later, [box.neap.io](http://box.neap.io)  
**Project Owner:** Michaël "[e7d](https://github.com/e7d)" Ferrand

## Prerequisites

In order to build the Neap Box effectively, you'll need to have a few tools installed:

1. Install [Git](https://git-scm.com)
2. Install [VirtualBox](http://virtualbox.org)
3. Install [Vagrant](http://vagrantup.com)

### Windows-specific ###

1. Add the Git binaries to your path

### Recommended

1. Use a development workstation with at least 2 cores and 8GB of RAM, as Vagrant should be allocated 1GB of RAM
2. Install [Vagrant::VBGuest](https://github.com/dotless-de/vagrant-vbguest), to manage the host's VirtualBox Guest Additions on the guest system  
`vagrant plugin install vagrant-vbguest`

## Build ##

1. `git clone https://github.com/e7d/neap-box.git` to clone the latest version
2. Change into the directory `neap-box`
3. Run `vagrant up`
4. Run `vagrant package --output neap.box`

**Note**: Steps 3. and 4. can be replaced with a call to `build.sh` on bash available environments.

## What you get ##

After the build process is done, you have a file named `neap.box` that can be imported in Vagrant or VirtualBox.

### Software stack ###

Neap box uses Vagrant's [shell provisioner](https://docs.vagrantup.com/v2/provisioning/shell.html) over a large collection of scripts to kick things off.

Once Vagrant is done provisioning the VM, you will have a box containing:

* [Debian](https://www.debian.org/) Jessie 8.8, as operating system, with:
    * [VirtualBox](https://www.virtualbox.org/) Guest Additions 5.1.22
* [Let's Encrypt Certbot](https://certbot.eff.org/) 0.11.1, as SSL certificate generator
* [jq](https://stedolan.github.io/jq/) 1.5, as JSON processor
* [PostgreSQL](http://www.postgresql.org/) 9.6.2, as database system
* [Redis](http://redis.io/) 3.2.8, as data structure store
* [MailCatcher](https://mailcatcher.me/) 0.6.5 as mail catching server
* [nginx](http://nginx.org/) 1.11.10, as web server, with:
    * [OpenSSL](https://www.openssl.org/) 1.1.0e, as SSL module
    * [nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module) 1.1.11, as streaming handler (RTMP, HLS and DASH protocols)
* [PHP](http://php.net/) 7.1.2, as server-side scripting language, with:
    * [PHP-FPM](http://php-fpm.org/) 7.1.2, as PHP process manager
    * [PhpRedis](https://github.com/phpredis/phpredis) 3.0.0, as PHP extension for Redis
    * [Xdebug](http://xdebug.org/) 2.5.0, as debugger and profiler tool
    * [Composer](https://getcomposer.org/) 1.3.2, as dependency manager
* [NodeJS](https://nodejs.org/) 6.10.0, as JavaScript runtime
    * [NPM](https://www.npmjs.com/) 4.3.0, as JavaScript package Manager
    * [Newman](https://github.com/postmanlabs/newman) 3.4.3, as [Postman](http://getpostman.com/) collection runner
* [FFmpeg](https://www.ffmpeg.org/) 2.8.11, as media converter
* [UnrealIRCd](https://www.unrealircd.org/) 4.0.11, as IRC server daemon, with:
    * [Anope](https://www.anope.org/) 2.0.5, as IRC services daemon
