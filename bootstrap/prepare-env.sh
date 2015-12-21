#!/bin/bash

try
(
    throwErrors

    echo "Update packages to the latest version"
    export DEBIAN_FRONTEND=noninteractive
    apt-get -y -q update
    apt-get -y -q -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
    apt-get -y -q dist-upgrade
    apt-get -y install facter linux-headers-$(uname -r) build-essential zlib1g-dev libssl-dev libreadline-gplv2-dev >/dev/null

    echo "Install standard packages"
    apt-get -y -q install curl git pkg-config unzip

    echo "Tweak SSH daemon"
    echo 'UseDNS no' >> /etc/ssh/sshd_config

    echo "Tweak Grub"
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
)
catch || {
    case $ex_code in
        *)
            echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
            throw $ex_code
        ;;
    esac
}
