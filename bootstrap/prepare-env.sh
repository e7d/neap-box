#!/bin/sh

# Update the box
echo "Update to latest version"
export DEBIAN_FRONTEND=noninteractive
apt-get -y -q update
apt-get -y -q -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
apt-get -y -q dist-upgrade
apt-get -y install facter linux-headers-$(uname -r) build-essential zlib1g-dev libssl-dev libreadline-gplv2-dev >/dev/null

# Install some useful and universal tools
echo "Install standard packages"
apt-get -y -q install curl git unzip

# Tweak sshd to prevent DNS resolution (speed up logins)
echo 'UseDNS no' >> /etc/ssh/sshd_config

# Remove 5s grub timeout to speed up booting
cat <<EOF > /etc/default/grub
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.

GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX="debian-installer=en_US"
EOF

update-grub

exit 0
