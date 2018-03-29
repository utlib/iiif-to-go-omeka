#!/bin/bash
read -p 'Enter the name of the archive to create in shared (without .zip extension): ' zipname
read -p 'Enter the slug of the Omeka instance to back up: ' slug
vagrant ssh --command "omekash archive /home/vagrant/shared/${zipname}.zip ${slug}"
