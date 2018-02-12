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
  config.vm.provision "file", source: "webseed", destination: "/home/vagrant/webseed"
  config.vm.provision "shell", inline: <<-SHELL
	cp -Rpf /home/vagrant/webseed/* /var/www/html
	rm -Rf /home/vagrant/webseed
  SHELL
  
  # Provision MySQL from root
  config.vm.provision "shell", path: "setup/mysql.sh", args: "password"
  
  # Provision Loris from root
  config.vm.provision "shell", path: "setup/loris.sh"

  # Provision an empty Omeka 2.5 stable
  config.vm.provision "file", source: "sql/omeka_main.sql", destination: "/tmp/omeka_main.sql"
  config.vm.provision "shell", path: "setup/omeka.sh", args: ["/tmp/omeka_main.sql"]
  
  # Provision shared paths
  config.vm.synced_folder "shared", "/home/vagrant"
  config.vm.synced_folder "loris", "/usr/local/share/images/synced"
  
  # Ask user to visit 127.0.0.1:8080
  config.vm.post_up_message = "IIIF to Go is ready! Visit 127.0.0.1:8080 on your browser to get started."
end
