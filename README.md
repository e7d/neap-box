# Neap Box

A Vagrant box for [Neap](https://github.com/e7d/neap) development.

## Read me first

This project aims to give you the necessary tools to build yourself the Neap Box.  
**Note:** If you want to directly use the Neap Box, you will never have to build it yourself! Instead, get it from [releases](./releases) or [Atlas](https://atlas.hashicorp.com/) by [Hashicorp](https://hashicorp.com/):
* [Neap Box](https://atlas.hashicorp.com/e7d/boxes/neap-box)

## About

**Version:** 1.2.0  
**Web:** Coming later, [box.neap.io](http://box.neap.io)  
**Project Owner:** Michaël "[e7d](https://github.com/e7d)" Ferrand

## Prerequisites

In order to build the Neap Box effectively, you'll need to have a few tools installed:

1. Install [Git](https://git-scm.com)
1. Install [VirtualBox](http://virtualbox.org)
1. Install [Vagrant](http://vagrantup.com)

### Windows-specific ###

1. Add the Git executables to your path

### Recommended

1. Use a development workstation with at least 2 cores and 8GB of RAM, as Vagrant should be allocated 1GB of RAM
1. Install [Vagrant::VBGuest](https://github.com/dotless-de/vagrant-vbguest), to manage the host's VirtualBox Guest Additions on the guest system  
`vagrant plugin install vagrant-vbguest`

## Build ##

1. `git clone https://github.com/e7d/neap-box.git` to clone the latest version
1. Change into the directory `neap-box`
1. Run `vagrant up`
1. Run `vagrant package --output neap.box`

## What you get ##

After the build process is done, you have a file named `neap.box` that can be imported in Vagrant or VirtualBox.

### Software stack ###

Neap box uses Vagrant's [shell provisioner](https://docs.vagrantup.com/v2/provisioning/shell.html) over a large collection of scripts to kick things off.

Once Vagrant is done provisioning the VM, you will have a box containing:

* [Debian](https://www.debian.org/) Jessie 8.3, as operating system, with:
    * [VirtualBox](https://www.virtualbox.org/) Guest Additions 5.0.14
* [Let's Encrypt](https://letsencrypt.org/) 0.4.0, as SSL certificate generator
* [nginx](http://nginx.org/) 1.9.12, as web server, with:
    * [OpenSSL](https://www.openssl.org/) 1.0.2f, as SSL module
    * [nginx-rtmp-module](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module) 1.1.7, as streaming handler (RTMP, HLS and DASH protocols)
* [Redis](http://redis.io/) 3.0.7, as data structure store
* [PHP](http://php.net/) 7.0.3, as server-side scripting language, with:
    * [PHP-FPM](http://php-fpm.org/) 7.0.3, as PHP process manager
    * [PhpRedis](https://github.com/phpredis/phpredis) 2.2.8-devphp7, as PHP extension for Redis
    * [Xdebug](http://xdebug.org/) 2.4.0RC4, as debugger and profiler tool
    * [Composer](https://getcomposer.org/) 1.0-dev, as dependency manager
* [PostgreSQL](http://www.postgresql.org/) 9.5.1, as database system
* [MailCatcher](http://mailcatcher.me/) 0.6.4 as mail catching server
* [NPM](https://www.npmjs.com/) 3.7.2, as JavaScript package Manager
* [FFmpeg](https://www.ffmpeg.org/) 2.8.6, as media converter
* [UnrealIRCd](https://www.unrealircd.org/) 4.0.1, as IRC server daemon, with:
    * [Anope](https://www.anope.org/) 2.0.3, as IRC services daemon
