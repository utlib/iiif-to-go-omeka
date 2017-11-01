# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant configuration header: DO NOT CHANGE
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  # Forwarded ports
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 81, host: 8181
  
  # VirtualBox settings
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
  end

  # Set up 
  config.vm.provision "shell", path: "setup/boot.sh"
  
  # Upload command line tools
  config.vm.provision "file", source: "opt-tools/omekash.sh", destination: "/home/vagrant/omekash"
  config.vm.provision "shell", inline: <<-SHELL
	mv /home/vagrant/omekash /usr/local/bin
	chmod +x /usr/local/bin/omekash
  SHELL
  
  # Provision Apache from root
  config.vm.provision "shell", path: "setup/apache.sh"
  
  # Provision MySQL from root
  config.vm.provision "shell", path: "setup/mysql.sh", args: "password"
  
  # Provision Loris from root
  config.vm.provision "shell", path: "setup/loris.sh"

  # Provision an empty Omeka 2.5 stable
  config.vm.provision "shell", path: "opt-tools/omekash.sh", args: ["new", "main", "--branch", "stable-2.5", "--repo", "https://github.com/omeka/Omeka.git"]
  
  # Provision shared paths
  config.vm.synced_folder "web", "/var/www/html"
  config.vm.synced_folder "loris", "/usr/local/share/images/synced"
end
