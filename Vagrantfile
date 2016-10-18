# -*- mode: ruby -*-
# vi: set ft=ruby :

# number of instances
$instances = (5).to_i

id = 1
idm = 0

# All Vagrant configuration is done below. Please don't change it unless you know what you're doing.
Vagrant.configure("2") do |config|
  
  	$instances.times do |n|
  		id = id+1
  		type = "webapp"
  		memory = "1024"
  		idm = id - 4
  		if id == 2
  			type = "master"
  			# memory = "1024"
  		elsif id == 3
  			type = "database"
  			memory = "2048"
  		elsif id == 4
  			type = "proxy"
  			memory = "512"
  		end

    	ip = "200.150.100.#{id}"
    	name = (type == 'webapp') ? "#{type}-#{idm}" : "#{type}"

    	config.vm.define name do |instance|
    		instance.vm.hostname = name
      		instance.vm.box = "bento/ubuntu-16.04"

      		instance.vm.provision :hosts

			# ip
			instance.vm.network "private_network", :ip => ip

			instance.vm.provider "virtualbox" do |vb|
			 	# Customize the amount of memory on the VM:
			 	vb.memory = memory
			 	vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
			end

      		instance.vm.provision :shell, :path => 'scripts/init.sh'
      		
      		# 
      		instance.vm.provision :puppet do |puppet|
				# puppet.options = '--verbose --summarize --hiera_config=/vagrant/hiera-no-consul.yaml --modulepath=/vagrant/puppet/modules:/puppet_modules --fileserverconfig=/vagrant/puppet/fileserver.conf'
				puppet.options = '--summarize --hiera_config=/vagrant/hiera-no-consul.yaml --modulepath=/vagrant/puppet/modules:/puppet_modules --fileserverconfig=/vagrant/puppet/fileserver.conf'
				puppet.manifests_path = "puppet/manifests"
				puppet.manifest_file = "consul.pp"
			end
			# 
      		instance.vm.provision :puppet do |puppet|
				# puppet.options = '--verbose --summarize --hiera_config=/vagrant/hiera.yaml --modulepath=/vagrant/puppet/modules:/puppet_modules --fileserverconfig=/vagrant/puppet/fileserver.conf'
				puppet.options = '--summarize --hiera_config=/vagrant/hiera.yaml --modulepath=/vagrant/puppet/modules:/puppet_modules --fileserverconfig=/vagrant/puppet/fileserver.conf'
				puppet.manifests_path = "puppet/manifests"
				puppet.manifest_file = "base.pp"
			end

			# instance.vm.provision "shell", inline: "consul join master" unless type == 'master'
    	end
    end
end
