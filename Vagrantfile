Vagrant.configure(2) do |config|
    config.vm.define "Neap Box" do |node|
        # For a complete reference, please see the online documentation at
        # https://docs.vagrantup.com.

        # General configuration
        node.vm.hostname = "neap-box"
        node.vm.box = "debian/jessie64"

        # Network configuration
        node.vm.network "private_network", ip: "192.168.32.20"

        # Synced folder configuration
        node.vm.synced_folder ".", "/vagrant", type: "nfs"

        # VirtualBox provider
        node.vm.provider "virtualbox" do |vb|
            # System configuration
            vb.name = "Neap Box"
        end

        #  VirtualBox Guest update
        node.vbguest.auto_update = true
        node.vbguest.no_remote = true

        # Provisioning script
        node.vm.provision "shell" do |s|
            s.inline = "/bin/bash /vagrant/bootstrap.sh | tee -a /vagrant/bootstrap.log"
            s.keep_color = true
        end
    end
end
