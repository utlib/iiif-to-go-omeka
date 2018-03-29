#!/bin/bash
read -p 'Enter the name of the archive in shared (without .zip extension): ' zipname
read -p 'Enter the new slug of the restored installation: ' slug
vagrant ssh --command "sudo omekash restore /home/vagrant/shared/${zipname}.zip ${slug}"
