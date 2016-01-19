# Neap Box

A Vagrant box for [Neap](https://github.com/e7d/neap) development.

## Read me first

This project aims to give you the necessary tools to build yourself the Neap Box.  
**Note:** If you want to directly use the Neap Box, you will never have to build it yourself! Instead, get it from [releases](./releases) or [Atlas](https://atlas.hashicorp.com/) by [Hashicorp](https://hashicorp.com/):
* [Neap Box](https://atlas.hashicorp.com/e7d/boxes/neap-box)

## About

**Version:** 1.0.6  
**Web:** Coming later, [box.neap.io](http://box.neap.io)  
**Project Owner:** Michaël "[e7d](https://github.com/e7d)" Ferrand

## Prerequisites

In order to build the Neap Box effectively, you'll need to have a few tools installed:

1. Install [Git](https://git-scm.com)
1. Install [VirtualBox](http://virtualbox.org)
1. Install [Vagrant](http://vagrantup.com)

### Windows-specific ###

1. Add the Git executables to your path
1. Install [Vagrant::WinNFSd](https://github.com/winnfsd/vagrant-winnfsd), to use NFS on a Windows host  
`vagrant plugin install vagrant-winnfsd`

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

* [Debian](http://debian.org) Jessie 8.2, as operating system
* [FFmpeg](https://www.ffmpeg.org/) 2.6.5, as media converter
* [Let's Encrypt](https://letsencrypt.org/) 0.2.0.dev0, as SSL certificate generator
* [nginx](http://nginx.org/) 1.9.9, as web server, with:
    * [nginx-rtmp-module](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module) 1.1.7, as streaming handler (RTMP, HLS and DASH protocols)
* [PHP](http://php.net/) 7.0.2, as server-side scripting language, with:
    * [PHP-FPM](http://php-fpm.org/), as PHP process manager
    * [Xdebug](http://xdebug.org/) 2.4.0RC4, as debugger and profiler tool
    * [Memcached](http://memcached.org/) 1.4.21, as memory object cache
    * [Composer](https://getcomposer.org/) 1.0-dev, as dependency manager
* [PostgreSQL](http://www.postgresql.org/) 9.5.0, as database system
* [UnrealIRCd](https://www.unrealircd.org/) 4.0.0, as IRC server daemon, with:
    * [Anope](https://www.anope.org/) 2.0.2, as IRC services daemon
* [NPM](https://www.npmjs.com/) 3.5.3, as Package Manager, with:
    * [JS Hint](http://jshint.com/) 2.9.1, as JavaScript code quality Tool
    * [Yeoman](http://yeoman.io/) 1.6.0, as JavaScript code generator
    * [Bower](http://bower.io/) 1.7.2, as web package manager
    * [Grunt](http://gruntjs.com/) CLI 0.1.13, as JavaScript task runner
    * [Jasmine](http://jasmine.github.io/) 2.4.1, as JavaScript testing framework
    * [Karma](http://karma-runner.github.io/) CLI 0.1.2, as JavaScript test runner
* Considered: [Varnish](http://varnish-cache.org/), as static files cache
