# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant configuration header: DO NOT CHANGE
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  
  # Uncomment this line when packaging the box!
  config.ssh.insert_key = false

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
  
  # Download command line tools and associated hooks
  config.vm.provision "file", source: "omekash_hooks", destination: "/home/vagrant/omekash_hooks"
  config.vm.provision "shell", inline: <<-SHELL
	git clone https://github.com/utlib/omekash.git /home/vagrant/omekash
	mv /home/vagrant/omekash/omekash /usr/local/bin/omekash
	chmod +x /usr/local/bin/omekash
	rm -Rf /home/vagrant/omekash
	mv /home/vagrant/omekash_hooks/* /usr/local/bin
	rm -Rf /home/vagrant/omekash_hooks
  SHELL
  
  # Provision Apache from root
  config.vm.provision "shell", path: "setup/apache.sh"
  config.vm.provision "file", source: "splash", destination: "/home/vagrant/splash"
  config.vm.provision "shell", inline: <<-SHELL
	cp -Rpf /home/vagrant/splash/* /var/www/html
	rm -Rf /home/vagrant/splash
  SHELL
  
  # Provision MySQL from root
  config.vm.provision "shell", path: "setup/mysql.sh", args: "password"
  
  # Provision Loris from root
  config.vm.provision "shell", path: "setup/loris.sh"

  # Provision an empty Omeka 2.5 stable
  config.vm.provision "file", source: "sql/omeka_main.sql", destination: "/tmp/omeka_main.sql"
  config.vm.provision "shell", path: "setup/omeka.sh", args: ["/tmp/omeka_main.sql"]
  
  # Provision shared paths
  config.vm.synced_folder "shared", "/home/vagrant/shared", create: true
  config.vm.synced_folder "loris", "/usr/local/share/images/synced", create: true
  
  # Ask user to visit 127.0.0.1:8080
  config.vm.post_up_message = "IIIF to Go is ready! Visit 127.0.0.1:8080 on your browser to get started."
end
