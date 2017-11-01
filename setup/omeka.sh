#!/bin/bash
# omeka.sh <seedsql>

seedsql="$1"
if [ ! -d /var/www/html/omeka-main ]; then
	omekash new main --branch stable-2.5 --repo https://github.com/omeka/Omeka.git
	mysql -u root --password="password" omeka_main < $seedsql
	rm -f "$seedsql"
	cp -p /var/www/html/omeka-main/plugins/IiifItems/placeholders/*.jpg /var/www/html/omeka-main/files/original
fi
