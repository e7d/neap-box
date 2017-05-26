#!/bin/bash

. /vagrant/resources/colors.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

# Removing leftover leases and persistent rules
echo "Cleaning up dhcp leases and rules"
rm /var/lib/dhcp/*

# Make sure Udev doesn't block our network
echo "Cleaning up udev rules"
rm -rf /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo "Purge old kernels"
apt-get -y -q purge $(dpkg -l|egrep '^ii  linux-(im|he)'|awk '{print $2}'|grep -v `uname -r`)
update-grub

echo "Update packages to the latest version"
export DEBIAN_FRONTEND=noninteractive
apt-get -y -q update
apt-get -y -q -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
apt-get -y -q upgrade
apt-get -y -q dist-upgrade

echo "Clean packages"
apt-get -yq autoremove --purge
dpkg -l | grep '^rc' | awk '{print $2}' | xargs dpkg --purge
apt-get -yq clean

echo "Remove APT related files"
find /var/lib/apt -type f | xargs rm -f

echo "Remove unnecessary documentation"
find /var/lib/doc -type f | xargs rm -f

echo "Cleanup log files"
find /var/log -type f | while read f; do echo -ne '' > $f; done;

echo "Remove all temporary files"
rm -rf /tmp/*
rm -rf /usr/src/*
rm -rf /var/tmp/*

echo "Clean history"
unset histfile
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

# To remove history, execute the following logged in through SSH:
# cat /dev/null > ~/.bash_history && history -c && exit
