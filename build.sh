#!/bin/bash

# Common
vagrant_plugin_install() {
	echo "Install Vagrant plugin: $1"
	plugins=$(vagrant plugin list | grep $1)
	if [[ -z $plugins ]]; then
		vagrant plugin install $1
	else
		vagrant plugin update $1
	fi
}
build() {
	if [ -z $1 ]; then
		echo "No provider"
		exit 1;
	fi
	vagrant destroy --force
	vagrant up --provider=$1 --install-provider --destroy-on-error
}
package() {
	rm -rf neap.box
	vagrant package --output neap.box
}

# VirtualBox
config_virtualbox() {
	echo "Configure VirtualBox"
	vagrant_plugin_install vagrant-vbguest
}
build_virtualbox() {
	echo "Build VirtualBox"
	build virtualbox
	package
}

# Digital Ocean
setup_digital_ocean_token() {
	echo "Setup Token for Digital Ocean"
	if [[ ! -e resources/digital-ocean/token ]]; then
		read -p "Token: " token
		echo $token >resources/digital-ocean/token
	else
		token=$(cat resources/digital-ocean/token)
	fi

	vagrant digitalocean-list images $token >/dev/null 2>&1
	if [[ 1 -eq $? ]]; then
		echo "Invalid token for Digital Ocean!"
		rm resources/digital-ocean/token
		setup_digital_ocean_token
	fi
}
setup_digital_ocean_keys() {
	timestamp=`date +%Y%m%d-%H%M%S`
	echo -e  'y\n' | ssh-keygen -t rsa -b 2048 -f resources/digital-ocean/id_rsa -N '' -C "neap-box@$timestamp"
}
config_digital_ocean() {
	echo "Configure Digital Ocean"
	vagrant_plugin_install vagrant-vbguest
	vagrant_plugin_install vagrant-digitalocean
	setup_digital_ocean_token
	setup_digital_ocean_keys
}
build_digital_ocean() {
	echo "Build Digital Ocean"
	build digital_ocean
}

# Program
while true; do
	echo "What provider do you want to use?"
	echo "1. VirtualBox (local, default)"
	echo "2. Digital Ocean (cloud)"
	read -p "provider [1]: " choice
	case "$choice" in
	  1|v|"" )
	  	config_virtualbox
	  	build_virtualbox
		break;;
	  2|d )
	  	config_digital_ocean
		build_digital_ocean
		break;;
	esac
done
