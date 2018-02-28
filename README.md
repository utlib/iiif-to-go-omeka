# IIIF in a Box

IIIF in a Box is a set of Vagrant scripts that set up portable, fully functional IIIF virtual environments on your system. You can use IIIF in a Box to easily create rich IIIF-based exhibits on the go, set up a workshop, or evaluate IIIF risk-free.

## Bundled Software

* Omeka 2.5
* Loris 2.0
* IIIF Toolkit 1.0.0

## System Requirements

* Windows 7 or higher / Mac OS X El Capitan or higher / Ubuntu 14.04 LTS or higher
* At least 4GB available hard drive space
* 4GB RAM total or more, at least 2GB available
* VirtualBox 5.1.30+ or 5.2.6+ or above ([link](https://www.virtualbox.org/))
* Vagrant 2.0.2 or above ([link](https://www.vagrantup.com))
	* (Windows only) WMF 4.0 or above
	
Note: If you do not already have VirtualBox and Vagrant installed, please install VirtualBox first and Vagrant second.

## Installation

* If VirtualBox is not installed, [download](https://www.virtualbox.org/wiki/Downloads) and install it.
	* In the installer's "Custom Setup" step, ensure that "VirtualBox Networking" is set to be installed. 
	* Restart your system after the installer finishes.
* If Vagrant is not installed, [download](https://www.vagrantup.com/downloads.html) and install it.
* Clone this repository or download its zip file.
- Double-click the start file for your system (`start.bat` for Windows, `start.command` for Mac OS X, `start.sh` for Ubuntu).
- Allow up several minutes for box dependencies to download and set up.

If installation is successful, a browser window should appear notifying that IIIF in a Box is ready.

*Command Line Usage: You can also start IIIF to Go using `vagrant up`. When it is done setting up, simply browse to `http://127.0.0.1:8080`.*

## Usage

To begin, simply run `start.bat` for Windows, `start.command` for Mac OS X, or `start.sh` for Ubuntu. The box should start up within a minute. When it is done starting up, a browser window should appear notifying that IIIF in a Box is ready.

To end, simply run `stop.bat` for Windows, `stop.command` for Mac OS X, or `stop.sh` for Ubuntu.

*Command Line Usage: You can also start IIIF to Go using `vagrant up` and shut it down using `vagrant halt`.*

## Uninstallation

Run `uninstall.bat` if you use Windows, `uninstall.command` if you use Mac OS X or `uninstall.sh` if you use Ubuntu. This will remove the VirtualBox image generated during installation.

*Command Line Usage: You can uninstall IIIF to Go using `vagrant destroy`. If you wish to see diagnostic output while the box is starting up, run `vagrant up --debug`.*

## License

IIIF in a Box is licensed under Apache License 2.0.
