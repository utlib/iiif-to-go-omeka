#!/bin/bash
# apache.sh

export DEBIAN_FRONTEND=noninteractive
echo "IIIF in a Box: Installing Apache..."

# Update packages and install tools
apt-get install -qqy apache2 php libapache2-mod-php php-curl php-mcrypt php7.0-gd php-imagick > /dev/null

# Override /var/www/html properties
echo '
<VirtualHost *:80>
	ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

	ErrorLog ${APACHE_LOG_DIR}/html_error.log
	CustomLog ${APACHE_LOG_DIR}/html_access.log combined

	<Directory /var/www/html>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride All
		Order allow,deny
		Allow from all
		Require all granted
		RewriteEngine On
	</Directory>
</VirtualHost>
' > /etc/apache2/sites-available/000-default.conf
a2enmod rewrite > /dev/null
service apache2 restart > /dev/null
