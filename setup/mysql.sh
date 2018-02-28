#!/bin/bash
# mysql.sh <password>

export DEBIAN_FRONTEND=noninteractive
echo "IIIF in a Box: Installing MySQL..."

PASSWORD="$1"

# Install MySQL with preset password
debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
apt-get install -qqy mysql-server php-mysql > /dev/null 2>&1

# Install PHPMyAdmin
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
apt-get install -qqy phpmyadmin > /dev/null 2>&1
