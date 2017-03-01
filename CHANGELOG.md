## v1.4.0 (unreleased)
* updated Debian Jessie to version 8.7
* updated VirtualBox Guest additions to version 5.1.14
* updated Lets Encrypt Certbot to version 0.11.1
* updated PostgreSQL to version 9.6.2
* updated Redis to version 3.2.8
* updated nginx to version 1.11.10
* updated OpenSSL to version 1.1.0e
* changed from "dotdeb" to "sury" repository for PHP and PHP-FPM
* updated PHP and PHP-FPM to version 7.1.2
* updated Composer to version 1.3.2
* updated NodeJS to version 6.9.5
* updated NPM to version 4.2.0
* updated Newman to version 3.4.3
* updated FFmpeg to version 2.8.11
* updated UnrealIRCd to version 4.0.11
* updated Anope to version 2.0.5
* fixed composer alias behavior in composer.bashrc

## v1.3.1 (2016-12-22)
* added apt packages clean
* updated VirtualBox Guest additions to version 5.1.12
* updated Redis to version 3.2.6
* updated PHP and PHP-FPM to version 7.0.14
* updated Xdebug to version 2.5.0
* updated Composer to version 1.2.4
* updated NodeJS to version 6.9.2
* updated NPM to version 4.0.5
* updated Newman to version 3.3.1
* updated FFmpeg to version 2.8.9
* updated UnrealIRCd to version 4.0.9
* fixed config settings for UnrealIRCd 4.0.9

## v1.3.0 (2016-10-31)
* updated Debian Jessie to version 8.6
* updated VirtualBox Guest additions to version 5.1.8
* updated Lets Encrypt Certbot to version 0.9.3
* updated PostgreSQL to version 9.6.1
* updated Redis to version 3.2.4
* updated MailCatcher to version 0.6.5
* updated nginx to version 1.10.2
* updated OpenSSL to version 1.0.2j
* updated nginx-rtmp-module to version 1.1.10
* updated PHP and PHP-FPM to version 7.0.12
* updated NodeJS to version 6.9.1
* updated NPM to version 3.10.9
* updated Newman to version 3.2.0
* updated FFmpeg to version 2.8.8
* updated UnrealIRCd to version 4.0.7
* added a "Neap" group attribution to the VirtualBox machine
* fixed Vagrantfile configuration

## v1.2.13 (2016-09-23)
* updated VirtualBox Guest additions to version 5.1.6
* updated PostgreSQL to version 9.5.4
* updated nginx-rtmp-module to version 1.1.9
* updated PHP and PHP-FPM to version 7.0.11
* updated PHP setup to get Xdebug from repository instead of building it
* updated Composer to version 1.2.1
* fixed bash alias that runs Composer without Xdebug
* updated NodeJS to version 6.6.0
* updated NPM to version 3.10.8
* updated Newman to version 3.1.1
* updated mailcatcher setup by removing ri and rdoc from installation
* updated UnrealIRCd to version 4.0.6

## v1.2.12 (2016-08-08)
* fixed Debian reference box to use edge version again (8.5.2)
* added bash alias to run Composer without Xdebug
* updated VirtualBox Guest additions to version 5.1.2
* updated Redis to version 3.2.3
* updated PHP and PHP-FPM to version 7.0.9
* added php7.0-mbstring extension
* added php7.0-zip extension
* updated Xdebug to version 2.4.1
* updated Composer to version 1.2.0
* updated NodeJS to version 6.3.1
* fixed FFmpeg repository (deb-multimedia) keyring
* updated UnrealIRCd to version 4.0.5
* updated Anope to version 2.0.4

## v1.2.11 (2016-07-13)
* improved build script
* updated nginx-rtmp-module to version 1.1.8
* updated NodeJS to version 6.3.0
* updated NPM to version 3.10.5

## v1.2.10 (2016-07-04)
* fixed Debian reference box to version 8.5.0 as 8.5.1 is not usable as is
* updated VirtualBox Guest additions to version 5.0.24
* updated NPM to version 3.10.3
* updated Newman to version 2.1.2

## v1.2.9 (2016-06-27)
* updated Debian Jessie to version 8.5
* updated Let's Encrypt Certbot to version 0.8.1
* updated Redis to version 3.2.1
* updated PHP and PHP-FPM to version 7.0.8
* added missing PHP modules for PHP 7.0.8
* updated PhpRedis to version 3.0.0
* updated Composer to version 1.1.3
* updated NodeJS to version 6.2.2
* updated NPM to version 3.10.2
* updated Newman to version 2.1.1
* updated UnrealIRCd to version 4.0.4
* improved Vagrantfile for better CPU use
* fixed PhpRedis and Xdebug bootstrap scripts

## v1.2.8 (2016-06-03)
* added newman in version 2.0.9
* updated Let's Encrypt Certbot to version 0.7.0
* updated PHP and PHP-FPM to version 7.0.7
* updated Composer to version 1.1.2
* updated NodeJS to version 6.2.1
* updated NPM to version 3.9.5
* updated nginx to version 1.10.1, fixing [CVE-2016-4450](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-4450)
* improved tree display in check version
* centralized apt packages dependencies from MailCatcher

## v1.2.7 (2016-05-26)
* fixed Let's Encrypt setup to use the new repository certbot/certbot
* updated Let's Encrypt Certbot (previously Let's Encrypt Client) to version 0.6.0
* updated PostgreSQL to version 9.5.3
* updated Redis to version 3.2.0
* updated nginx to version 1.10.0
* updated nginx build script to compile in debug mode
* updated Composer to version 1.1.0
* updated NodeJS to branch 6.x
* updated NPM to version 3.9.0
* updated build scripts using make to benefit from all available cores
* moved bootstrap script runner to project root
* fixed numerous typos in README.md

## v1.2.6 (2016-05-06)
* fixed broken Redis runner script
* added jq as json processor
* updated VirtualBox Guest Additions to version 5.0.20
* updated OpenSSL to version 1.0.2h
* updated PHP and PHP-FPM to version 7.0.6
* updated Composer to version 1.0.3
* updated NPM to version 3.8.7
* updated FFmpeg to version 2.8.7

## v1.2.5 (2016-04-28)
* downgraded nginx to version 1.9.10 to ensure nginx-rtmp-module compatibility
* disabled PHP OPcache by default
* added PHPUnit
* updated UnrealIRCd to version 4.0.3
* improved cleanup at every build step
* removed every PHP5 related packages

## v1.2.4 (2016-04-04)
* updated Debian to Jessie version 8.4
* updated nginx to version 1.9.13
* updated PHP and PHP-FPM to version 7.0.5
* updated Composer to version 1.0-beta2
* updated PostgreSQL to version 9.5.2
* updated NPM to version 3.8.5

## v1.2.3 (2016-03-22)
* updated bootstrap scripts tree for better coherence
* improved global script writting style
* made version checking more readable
* updated UnrealIRCd to version 4.0.2
* updated Xdebug to version 2.4.0 stable
* updated NPM to version 3.8.2

## v1.2.2 (2016-03-15)
* fixed FFmpeg setup
* normalized Let's Encrypt setup
* normalized folders structure
* fixed erroneous phpredis setup
* updated NPM to version 3.8.1

## v1.2.1 (2016-03-15)
* updated VirtualBox Guest Additions 5.0.16
* updated Let's Encrypt to version 0.4.2
* updated PHP and PHP-FPM to version 7.0.4
* updated nginx to version 1.9.12 with openssl 1.0.2g
* updated NPM to version 3.8.0
* improved redis configuration to support IPv6 and unix socket file
* simplified and aligned all bootstrap scripts
* updated all bootstrap scripts to be reused at will without issue
* simplified certificate related steps, do not generate dhparam anymore
* updated Xdebug setup to use releases instead of source
* added analytics

## v1.2.0 (2016-02-17)
* updated nginx to version 1.9.11
* updated PostgreSQL to version 9.5.1
* updated FFmpeg to version 2.8.6
* added MailCatcher, with version 0.6.4
* fixed Let's Encrypt recipe
* improved bootstrap:
  * global admin rights check
  * cleanup and shrinking
* switched to Debian Jessie base box with vboxsf module
* removed NFS for folder synchronization
* added bash build script, to run with `bash build.sh` on supported environments

## 1.1.3 (2016-02-08)
* dropped memcached
* added Redis, with version 3.0.7
* added PhpRedis, with version 2.2.5
* updated NPM to version 3.7.1

## 1.1.2 (2016-02-01)
* updated Debian Jessie to version 8.3
* updated Let's Encrypt to version 0.4.0.dev0
* updated nginx to version 1.9.10, built against OpenSSL 1.0.2f
* updated UnrealIRCd to version 4.0.1
* updated Anope to version 2.0.3
* updated NPM to version 3.6.0
* dropped all globally installed NPM packages
* dropped OpenSSL 1.0.2 build script, as it is not used outside of nginx

## 1.1.1 (2016-01-21)
* updated VirtualBox Guest additions to version 5.0.14
* updated Let's Encrypt to version 0.2.1.dev0
* improved installed software version check
* dropped Varnish from considered softwares

## 1.1.0 (2016-01-19)
* added NPM environment with:
  * JS Hint
  * Yeoman
  * Bower
  * Grunt
  * Jasmine
  * Karma
* updated bootstrap scripts to be launched standalone
* fixed disable OPCache for PHP CLI
* centralized apt dependencies installation
* centralized sources cleanup
* silenced on-going certificates generation
* updated nginx to mainline 1.9.9, being built against OpenSSL 1.0.2e sources
* updated bootstrap to ultimately display installed versions

## 1.0.5 (2016-01-11)
* added coding style definition file
* updated PostgreSQL to version 9.5
* updated PHP to version 7.0.2
* improved box compression script

## 1.0.4 (2016-01-04)
* updated UnrealIRCd to stable version 4.0.0
* modified nginx-rtmp-module reference to use back original repository from "arut"

## 1.0.3 (2015-12-23)
* fixed broken Let's Encrypt recipe

## 1.0.2 (2015-12-23)
* added alternative shutdown script to speed up `vagrant halt`
* modified resources, relocated to project root
* added memcached for PHP session storage
* added Let's Encrypt
* modified disk shrinking for better results
* modified nginx-rtmp-module reference to use fork from "sergey-dryabzhinsky"

## 1.0.1 (2015-12-21)
* modified script language to bash from shell for bootstrap
* fixed Unreal and Anope services
* added bootstrap error catching and management
* added bootstrap output logging
* added self-signed certificate generation
* splitted PHP and Xdebug setup
* added Memcached setup
* added Composer setup

## 1.0.0 (2015-12-18)
Initial release
