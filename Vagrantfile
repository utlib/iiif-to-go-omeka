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
  config.vm.provision "shell", inline: "mkdir -p /home/vagrant/.bash-tools && chown vagrant /home/vagrant/.bash-tools"
  config.vm.provision "file", source: "opt-tools/omekash.sh", destination: "/home/vagrant/.bash-tools/omekash"
  config.vm.provision "shell", inline: "chmod +x /home/vagrant/.bash-tools/omekash"
  config.vm.provision "shell", inline: <<-SHELL
	echo 'PATH=$PATH:/home/vagrant/.bash-tools' >> /home/vagrant/.bashrc
  SHELL
  
  # Provision Apache from root
  config.vm.provision "shell", path: "setup/apache.sh"
  config.vm.synced_folder "web", "/var/www/html"
  
  # Provision MySQL from root
  config.vm.provision "shell", path: "setup/mysql.sh", args: "password"
  
    # Provision Loris from root
  config.vm.provision "shell", path: "setup/loris.sh"
  config.vm.synced_folder "loris", "/usr/local/share/images"

  # Provision an empty Omeka 2.5 stable
  config.vm.provision "shell", path: "setup/omeka.sh"
end
