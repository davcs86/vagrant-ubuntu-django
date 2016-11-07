# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. Please don't change it unless you know what you're doing.
Vagrant.configure("2") do |config|

    config.vm.define "onesim" do |instance|
        instance.vm.hostname = "onesim"
        instance.vm.box = "bento/ubuntu-16.04"

        instance.vm.provision :shell, :path => 'scripts/update_repositories.sh'
        # databases
        instance.vm.provision :shell, :path => 'scripts/install_postgres.sh'
        instance.vm.provision :shell, :path => 'scripts/install_redis.sh'
        
        # 
        instance.vm.provision :shell, :path => 'scripts/install_gunicorn.sh'
        # instance.vm.provision :shell, :path => 'scripts/install_nginx.sh'

        # network
        instance.vm.network "private_network", :ip => "200.150.100.24"

        instance.vm.provider "virtualbox" do |vb|
            # Customize the amount of memory on the VM:
            vb.memory = "4096"
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "60"]
        end
        
    end
    
end
