Vagrant.configure(2) do |config|
    # Collect data about the host
    host = RbConfig::CONFIG['host_os']
    if host =~ /darwin/
        cpus = `sysctl -n hw.ncpu`.to_i
    elsif host =~ /linux/
        cpus = `nproc`.to_i
    else
        cpus = `wmic cpu get NumberOfCores`.split("\n")[2].to_i
    end

    config.vm.define "Neap Box" do |node|
        # For a complete reference, please see the online documentation at
        # https://docs.vagrantup.com.

        # General configuration
        node.vm.hostname = "neap-box"
        node.vm.box = "debian/contrib-jessie64"
        node.vm.box_version = ">= 8.5"

        # Synced folder configuration
        node.vm.synced_folder ".", "/vagrant"

        # VirtualBox provider
        node.vm.provider "virtualbox" do |vb|
            # System configuration
            vb.name = "Neap Box"
            vb.cpus = cpus
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
