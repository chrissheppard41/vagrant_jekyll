# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "jekyll"
  config.vm.define "Jekyll" do |base|
  end

  # Throw in our provisioning script
  #config.vm.provision "shell", path: "bootstrap.sh"

  # Map localhost:4000 to port 4000 inside the VM
  #config.vm.network "forwarded_port", guest: 4000, host: 4000
  #config.vm.network "private_network", ip: "192.168.3.33"

    

  config.vm.network :forwarded_port, host: 8080, guest: 80
  config.vm.network "private_network", ip: "192.168.3.33"
  config.vm.provision :shell, path: "shell/bootstrap.sh"
  config.vm.provision :shell, path: "shell/apache.sh"
  config.vm.provision :shell, path: "shell/ruby.sh"
  config.vm.provision :shell, path: "shell/php.sh"
  config.vm.provision :shell, path: "shell/mysql.sh"

  # Create a shared folder between guest and host
  #config.vm.synced_folder "www/", "/var/www", create: true

  #config.ssh.forward_agent = true

  # VirtualBox-specific configuration
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", 512]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

end