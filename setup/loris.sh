#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
echo "IIIF in a Box: Installing Loris..."

# Update packages and install tools
# apt-get install -qqy wget git unzip > /dev/null 2>&1

# Kakadu
# cd /usr/local/lib
# wget -q --no-check-certificate https://github.com/loris-imageserver/loris/raw/development/lib/Linux/x86_64/libkdu_v74R.so
# chmod 755 libkdu_v74R.so
# cd /usr/local/bin
# wget -q --no-check-certificate https://github.com/loris-imageserver/loris/raw/development/bin/Linux/x86_64/kdu_expand
# chmod 755 kdu_expand
apt-get install -qqy libopenjp2-tools > /dev/null 2>&1

# Python and image library dependencies
apt-get install -qqy libjpeg8 libjpeg8-dev libfreetype6 libfreetype6-dev zlib1g-dev liblcms2-2 liblcms2-dev liblcms2-utils libtiff5-dev libffi-dev > /dev/null 2>&1
ln -s /usr/lib/`uname -i`-linux-gnu/libfreetype.so /usr/lib/
ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so /usr/lib/
ln -s /usr/lib/`uname -i`-linux-gnu/libz.so /usr/lib/
ln -s /usr/lib/`uname -i`-linux-gnu/liblcms.so /usr/lib/
ln -s /usr/lib/`uname -i`-linux-gnu/libtiff.so /usr/lib/
echo "/usr/local/lib" >> /etc/ld.so.conf && ldconfig
apt-get install -qqy python3-dev python3-setuptools python3-pip > /dev/null 2>&1
pip3 uninstall -qq PIL > /dev/null 2>&1
pip3 uninstall -qq Pillow > /dev/null 2>&1
apt-get purge -qq python3-imaging > /dev/null 2>&1
pip3 install -qq Werkzeug > /dev/null 2>&1
pip3 install -qq configobj > /dev/null 2>&1
pip3 install -qq Pillow > /dev/null 2>&1

# WSGI
apt-get install -qqy libapache2-mod-wsgi-py3 > /dev/null 2>&1

# Loris packages
cd /opt
wget -q --no-check-certificate https://github.com/loris-imageserver/loris/archive/v3.2.1.zip
unzip -qq v3.2.1.zip > /dev/null 2>&1
mv loris-3.2.1/ loris/
rm v3.2.1.zip


# Loris user
useradd -d /var/www/loris -s /bin/false loris

# Image directory
cd /opt/loris

# Install
python3 ./setup.py install > /dev/null 2>&1
python3 ./bin/setup_directories.py
chown -R loris /var/cache/loris

# Loris-Apache integration
cd /etc/apache2
echo 'Listen *:81' >> ports.conf
echo '<VirtualHost *:81>
	ExpiresActive On
	ExpiresDefault "access plus 5184000 seconds"
	AllowEncodedSlashes On
	WSGIDaemonProcess loris user=loris group=loris processes=10 threads=15 maximum-requests=10000
	WSGIScriptAlias /loris /var/www/loris/loris.wsgi
	WSGIProcessGroup loris
	SetEnvIf Request_URI ^/loris loris
	CustomLog ${APACHE_LOG_DIR}/loris-access.log combined env=loris
</VirtualHost>

<Directory /var/www/loris>
		Order deny,allow
		Allow from all
		Require all granted
</Directory>' > sites-available/loris.conf
a2enmod expires > /dev/null 2>&1
a2enmod headers > /dev/null 2>&1
a2ensite loris > /dev/null 2>&1
service apache2 restart > /dev/null 2>&1
