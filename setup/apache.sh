#!/bin/bash
# apache.sh
	
# Update packages and install tools
apt-get update -y
apt-get install -y apache2 php libapache2-mod-php php-curl php-mcrypt php7.0-gd php-imagick

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
a2enmod rewrite
service apache2 restart
