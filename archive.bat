@echo off

set slug=main
set /p zipname=Enter the name of the archive to create in shared (without .zip extension): 
set /p slug=Enter the slug of the Omeka instance to back up: 
pushd "%~dp0"
vagrant ssh --command "omekash archive '/home/vagrant/shared/%zipname%.zip' '%slug%'"
popd
