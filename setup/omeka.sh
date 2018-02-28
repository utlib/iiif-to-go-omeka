#!/bin/bash
# omeka.sh <seedsql>

export DEBIAN_FRONTEND=noninteractive
echo "IIIF in a Box: Installing seeded Omeka instance..."

seedsql="$1"
if [ ! -d /var/www/html/omeka-main ]; then
	omekash new main --branch stable-2.5 --repo https://github.com/omeka/Omeka.git  > /dev/null 2>&1
	mysql -u root --password="password" omeka_main < $seedsql > /dev/null 2>&1
	rm -f "$seedsql"
	cp -p /var/www/html/omeka-main/plugins/IiifItems/placeholders/*.jpg /var/www/html/omeka-main/files/original
fi
