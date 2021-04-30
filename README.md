# IIIF to Go (Omeka Version)

IIIF to Go is a set of Vagrant scripts that set up portable, fully functional IIIF virtual environments on your system. You can use IIIF to Go to easily create rich IIIF-based exhibits on the go, set up a workshop, or evaluate IIIF risk-free.

## Bundled Software

* [Omeka Classic 2.8](http://omeka.org/classic/)
* [Loris 3.2.1](https://github.com/loris-imageserver/loris)
* [IIIF Toolkit 1.1.0](https://github.com/utlib/IiifItems)

## System Requirements

* Windows 10 or higher / Mac OS X Catalina or higher / Ubuntu 20.04 LTS or higher
* At least 4GB available hard drive space
* 4GB RAM total or more, at least 2GB available
* VirtualBox 6.1+ or above ([link](https://www.virtualbox.org/))
* Vagrant 2.2.15 or above ([link](https://www.vagrantup.com))
	* (Windows only) [WMF 4.0](https://www.microsoft.com/en-ca/download/details.aspx?id=40855) or above

Note: If you do not already have VirtualBox and Vagrant installed, please install VirtualBox first and Vagrant second.

## Installation

* If VirtualBox is not installed, [download](https://www.virtualbox.org/wiki/Downloads) and install it.
	* In the installer's "Custom Setup" step, ensure that "VirtualBox Networking" is set to be installed.
	* Restart your system after the installer finishes.
* If Vagrant is not installed, [download](https://www.vagrantup.com/downloads.html) and install it.
* Clone this repository or download its zip file.
- Double-click the start file for your system (`start.bat` for Windows, `start.command` for Mac OS X, `start.sh` for Ubuntu).
- Allow up several minutes for box dependencies to download and set up.

If installation is successful, a browser window should appear notifying that IIIF to Go is ready.

*Command Line Usage: You can also start IIIF to Go using `vagrant up`. When it is done setting up, simply browse to `http://127.0.0.1:8080`. If you wish to see diagnostic output while the box is starting up, run `vagrant up --debug`.*

## Usage

To begin, simply run `start.bat` for Windows, `start.command` for Mac OS X, or `start.sh` for Ubuntu. The box should start up within a minute. When it is done starting up, a browser window should appear notifying that IIIF to Go is ready.

To end, simply run `stop.bat` for Windows, `stop.command` for Mac OS X, or `stop.sh` for Ubuntu.

*Command Line Usage: You can also start IIIF to Go using `vagrant up` and shut it down using `vagrant halt`.*

## Exporting and Importing Omeka Archives

IIIF to Go supports exporting and importing zip archives of Omeka instances. This allows you to transfer installations between boxes and create local backups.

Omeka instances in IIIF to Go are referred to by their alphanumeric _slug_. This is the part after `omeka-` in the URL. The slug for the default installation is `main`.

To export an Omeka archive, run `archive.bat` for Windows, `archive.command` for Mac OS X, or `archive.sh` for Ubuntu. Enter the name of the zip archive to export (without the .zip extension) and the slug of the Omeka instance to export. If successful, the resulting archive should appear in the `shared` directory.

To import an Omeka archive as a new Omeka instance, move the zip archive into the `shared` directory. Then run `restore.bat` for Windows, `restore.command` for Mac OS X, or `restore.sh` for Ubuntu. Enter the name of the zip archive (without the .zip extension), followed by the slug of the new Omeka instance (alphanumeric characters only, up to 10 characters). If successful, you should be able to visit the new instance at `http://127.0.0.1:8080/omeka-<new slug>`.

## SSH Access and the`omekash` Shell Tool

While IIIF to Go is started, you can run administrative commands on it by running `ssh.bat` for Windows, `ssh.command` for Mac OS X, or `ssh.sh` for Ubuntu, or `vagrant ssh` from your command prompt.

Once you are logged into IIIF to Go, you can use the `omekash` shell tool to manage Omeka instances. Here is a list of commands (the default `sudo` credentials are `vagrant / vagrant`):

- `sudo omekash new <slug>`: Set up a new named Omeka instance. You will need to visit `http://127.0.0.1:8080/omeka-<slug>/install/install.php` to initialize its parameters.
  - `--branch <branch>`: Specify the branch to check out Omeka from. Default: `master`
  - `--repo <repository>`: Specify the repository to check out Omeka from. Default: `https://github.com/omeka/Omeka.git`
  - `--url <url>`: Use a download URL to a zip or tarball file instead of Git.
- `sudo omekash rm <slug>`: Remove the named Omeka instance.
- `sudo omekash clone <oldslug> <newslug>`: Make a copy of the named Omeka instance.
- `sudo omekash plug <slug>`: Download and add a plugin to the named Omeka instance. You must provide either a `--repo` or `--url` parameter, but not both.
  - `--branch <branch>`: Specify the branch to check out the plugin from. Can only be used with `--repo`. Default: `master`
  - `--repo <repository>`: Specify the repository to check out the plugin from.
  - `--url <url>`: Specify the URL to a zip or tarball file to download the plugin from.
- `sudo omekash unplug <slug> <plugin-name>`: Directly remove a plugin from the named Omeka instance. *Warning: Make sure to uninstall the plugin first!*
- `sudo omekash theme <slug>`: Download and add a theme from the given URL to the named Omeka instance. You must provide either a `--repo` or `--url` parameter, but not both.
  - `--branch <branch>`: Specify the branch to check out the theme from. Can only be used with `--repo`. Default: `master`
  - `--repo <repository>`: Specify the repository to check out the theme from.
  - `--url <url>`: Specify the URL to a zip or tarball file to download the theme from.
- `sudo omekash untheme <slug> <theme-name>`: Directly remove a theme from the named Omeka instance. *Warning: Make sure that the theme is not currently used!*
- `sudo omekash archive <zipname> <slug>`: Save the given Omeka instance and its associated database in the given zip file.
- `sudo omekash restore <zipname> <slug>`: Restore the Omeka instance archived in the given zip file (can be a local path or a download URL) to the new name. The new instance can be accessed at `http://127.0.0.1:8080/omeka-<newslug>`.

## Uninstallation

Run `uninstall.bat` if you use Windows, `uninstall.command` if you use Mac OS X or `uninstall.sh` if you use Ubuntu. This will remove the VirtualBox image generated during installation.

*Command Line Usage: You can uninstall IIIF to Go using `vagrant destroy`.*

## License

IIIF to Go (Omeka Version) is licensed under Apache License 2.0.
