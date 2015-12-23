# Neap Box

A Vagrant box for [Neap](https://github.com/e7d/neap) development.

## Read me first

This project aims to give you the necessary tools to build yourself the Neap Box.  
**Note:** If you want to directly use the Neap Box, you will never have to build it yourself! Instead, get it from [releases](./releases) or [Atlas](https://atlas.hashicorp.com/) by [Hashicorp](https://hashicorp.com/):
* [Neap Box](https://atlas.hashicorp.com/e7d/boxes/neap-box)

## About

**Version:** 1.0.3  
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
1. Run `vagrant package --output neap.box`

## What you get ##

### Software stack ###

Neap box uses a mixture of Vagrant's [shell provisioner](https://docs.vagrantup.com/v2/provisioning/shell.html) to kick things off.

Once Vagrant is done provisioning the VM, you will have a box running the latest Debian 8 (aka Jessie) containing:

* [FFmpeg](https://www.ffmpeg.org/) 2.6.5, as media converter
* [Let's Encrypt](https://letsencrypt.org/), as SSL certificate generator
* [nginx](http://nginx.org/) 1.8.0, as web server, with:
    * [nginx-rtmp-module](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module), as streaming handler (RTMP, HLS and DASH protocols)
* [PHP](http://php.net/) 7.0.1, as server-side scripting language, with:
    * [PHP-FPM](http://php-fpm.org/), as PHP process manager
    * [Xdebug](http://xdebug.org/) 2.4, as debugger and profiler tool
    * [Memcached](http://memcached.org/) 1.4, as memory object cache
    * [Composer](https://getcomposer.org/), as dependency manager
* [PostgreSQL](http://www.postgresql.org/) 9.4, as database system
* [UnrealIRCd](https://www.unrealircd.org/) 4.0.0-RC6, as IRC server daemon, with:
    * [Anope](https://www.anope.org/) 2.0.2, as IRC services daemon
* Considered: [Varnish](http://varnish-cache.org/), as static files cache
