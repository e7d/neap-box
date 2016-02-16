Vagrant.configure(2) do |config|
    config.vm.define "Neap Box" do |node|
        # For a complete reference, please see the online documentation at
        # https://docs.vagrantup.com.

        # General configuration
        node.vm.hostname = "neap-box"
        node.vm.box = "debian/contrib-jessie64"
        node.vm.box_version = ">= 8.3"

        # Network configuration
        node.vm.network "private_network", ip: "192.168.32.20"

        # Synced folder configuration
        node.vm.synced_folder ".", "/vagrant", type: "nfs"

        # VirtualBox provider
        node.vm.provider "virtualbox" do |vb|
            # System configuration
            vb.name = "Neap Box"
            vb.cpus = "4"
            vb.memory = "1024"
        end

        #  VirtualBox Guest update
        node.vbguest.auto_update = true
        node.vbguest.no_remote = true

        # Provisioning script
        node.vm.provision "shell" do |s|
            s.inline = "/vagrant/bootstrap.sh | tee /vagrant/bootstrap.log"
            s.keep_color = true
        end
    end
end
