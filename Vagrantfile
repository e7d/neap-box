Vagrant.configure(2) do |config|
    # Collect data about the host
    case RbConfig::CONFIG['host_os']
        when /cygwin|mswin|msys|mingw|bccwin|wince|emc|emx|windows/i
            # Windows
            cpus = `wmic cpu get NumberOfLogicalProcessors`.split("\n")[2].to_i
        when /linux|arch/i
            # linux
            cpus = `nproc`.to_i
        when /darwin|mac os/i
            # MacOS
            cpus = `sysctl -n hw.ncpu`.to_i
        else
            # Others...
            cpus = 2
    end

    config.vm.define "Neap Box" do |node|
        # For a complete reference, please see the online documentation at
        # https://docs.vagrantup.com.

        # General configuration
        node.vm.hostname = "box.neap.dev"
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
