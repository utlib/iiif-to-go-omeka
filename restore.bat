@echo off

set slug=main
set /p zipname=Enter the name of the archive in shared (without .zip extension): 
set /p slug=Enter the new slug of the restored installation: 
pushd "%~dp0"
vagrant ssh --command "sudo omekash restore '/home/vagrant/shared/%zipname%.zip' '%slug%'"
popd
