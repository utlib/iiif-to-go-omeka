#!/bin/bash
# omeka.sh

/home/vagrant/.bash-tools/omekash new main --branch stable-2.5 --repo https://github.com/omeka/Omeka.git
git clone https://github.com/utlib/IiifItems.git --recursive /var/www/html/omeka-main/plugins/IiifItems
