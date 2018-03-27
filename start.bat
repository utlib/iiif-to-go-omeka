@echo off

pushd "%~dp0"
vagrant up && start "" "http://127.0.0.1:8080"
popd
