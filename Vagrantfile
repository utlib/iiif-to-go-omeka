# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "Glucoz/ubuntu-xenial-lamp"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 81, host: 8181

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.memory = "2048"
  end
  
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
	
	# Update packages and install tools
	apt-get install -y wget git unzip
	
	# Loris
	# Kakadu
	cd /usr/local/lib
	wget --no-check-certificate https://github.com/loris-imageserver/loris/raw/development/lib/Linux/x86_64/libkdu_v74R.so \
		&& chmod 755 libkdu_v74R.so
	cd /usr/local/bin
	wget --no-check-certificate https://github.com/loris-imageserver/loris/raw/development/bin/Linux/x86_64/kdu_expand \
		&& chmod 755 kdu_expand
	# Python and image library dependencies
	apt-get install -y libjpeg8 libjpeg8-dev libfreetype6 libfreetype6-dev zlib1g-dev liblcms2-2 liblcms2-dev liblcms2-utils libtiff5-dev
	ln -s /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib/ \
		&& ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib/ \
		&& ln -s /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib/ \
		&& ln -s /usr/lib/`uname -i`-linux-gnu/liblcms.so /usr/lib/ \
		&& ln -s /usr/lib/`uname -i`-linux-gnu/libtiff.so /usr/lib/
	echo "/usr/local/lib" >> /etc/ld.so.conf && ldconfig
	apt-get install -y python-dev python-setuptools python-pip
	pip install --upgrade pip
	pip uninstall PIL
	pip uninstall Pillow
	apt-get purge python-imaging
	pip install Werkzeug
	pip install configobj
	pip install Pillow
	# WSGI
	apt-get install libapache2-mod-wsgi
	# Loris packages
	cd /opt
	wget --no-check-certificate https://github.com/loris-imageserver/loris/archive/2.0.1.zip \
		&& unzip 2.0.1.zip \
		&& mv loris-2.0.1/ loris/ \
		&& rm 2.0.1.zip
	# Loris user
	useradd -d /var/www/loris2 -s /sbin/false loris
	cd /opt/loris
	mkdir /usr/local/share/images
	cp -R tests/img/* /usr/local/share/images/
	./setup.py install
	cp etc/loris2.conf /etc/loris2.conf
	# Loris Apache
	cd /etc/apache2
	echo 'Listen *:81' >> ports.conf
	echo '<VirtualHost *:81>
		ExpiresActive On
		ExpiresDefault "access plus 5184000 seconds"
		AllowEncodedSlashes On
		WSGIDaemonProcess loris2 user=loris group=loris processes=10 threads=15 maximum-requests=10000
		WSGIScriptAlias /loris /var/www/loris2/loris2.wsgi
		WSGIProcessGroup loris2
		SetEnvIf Request_URI ^/loris loris
		CustomLog ${APACHE_LOG_DIR}/loris-access.log combined env=loris
	</VirtualHost>

	<Directory /var/www/loris2>
			Order deny,allow
			Allow from all
			Require all granted
	</Directory>' > sites-available/loris.conf
	a2enmod expires
	service apache2 restart
  SHELL
end
