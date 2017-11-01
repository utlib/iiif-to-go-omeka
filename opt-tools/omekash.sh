#!/bin/bash

# Configurations
rootuser="root"
rootpass="password"
httproot="/var/www/html"
lorisroot="/usr/local/share/images"
wwwuser="www-data"
wwwgroup="www-data"

# Functions
function usagehint {
	echo "Usage: omekash (new|rm|clone <origslug>|log|update) <slug> [--branch <branch>] [--repo <repository>] [--no-loris]"
	exit 2
}

function fail {
	>&2 echo "FAIL"
	exit 1
}

# omekanew <slug> <targetdir> <branch> <repository> <dbusername> <dbpassword>
function omekanew {
	# Capture arguments
	slug=$1
	targetdir=$2
	branch=$3
	repository=$4
	dbusername=$5
	dbpassword=$6
	
	# Stop if the target already exists
	if [ -d "$targetdir" ]; then
		>&2 echo "The target directory ${targetdir} already exists. Please remove this installation before continuing."
		fail
	fi

	# Create commands for generating database and database user
	sqlfile=`mktemp`
	echo "CREATE DATABASE omeka_${slug};" >> $sqlfile
	echo "CREATE DATABASE omeka_${slug}_test;" >> $sqlfile
	echo "CREATE USER ${dbusername} IDENTIFIED BY '"${dbpassword}"';" >> $sqlfile
	echo "GRANT ALL ON omeka_${slug}.* TO ${dbusername};" >> $sqlfile
	echo "GRANT ALL ON omeka_${slug}_test.* TO ${dbusername};" >> $sqlfile
	echo "FLUSH PRIVILEGES;" >> $sqlfile

	# Execute commands with mysql
	>&2 echo -n "Setting up MySQL database and user... "
	mysql -u "$rootuser" --password="$rootpass" < $sqlfile || fail
	>&2 echo "DONE"

	# Clone Omeka to target directory
	>&2 echo "Downloading Omeka..."
	git clone --branch "$branch" --recursive "$repo" "$targetdir" || fail
	>&2 echo "Omeka downloaded."
	
	# Add IIIF Toolkit
	>&2 echo "Downloading IIIF Toolkit for Omeka..."
	tmpdir=`mktemp -d`
	git clone https://github.com/utlib/IiifItems.git --recursive "$tmpdir/IiifItems"
	mv -f "$tmpdir/IiifItems" "$targetdir/plugins"
	rm -Rf "$tmpdir"

	# Start configuring Omeka
	>&2 echo -n "Configuring Omeka... "
	
	# Fill db.ini
	dbini="${targetdir}/db.ini"
	: > $dbini
	echo '[database]' >> $dbini
	echo 'host="localhost"' >> $dbini
	echo "username=\"${dbusername}\"" >> $dbini
	echo "password=\"${dbpassword}\"" >> $dbini
	echo "dbname=\"omeka_${slug}\"" >> $dbini
	echo 'prefix="omeka_"' >> $dbini
	echo 'charset="utf8"' >> $dbini

	# Fill .htaccess
	cp "${targetdir}/.htaccess.changeme" "${targetdir}/.htaccess" || fail
	echo 'SetEnv APPLICATION_ENV development' >> "${targetdir}/.htaccess"

	# Fill config.ini
	cp "${targetdir}/application/config/config.ini.changeme" "${targetdir}/application/config/config.ini" || fail

	# Fill tests/config.ini
	testsconfig="${targetdir}/application/tests/config.ini"
	teststemp="/tmp/omeka_${slug}_test"
	mkdir $teststemp
	: > $testsconfig
	echo '[testing]' >> $testsconfig
	echo 'db.host="localhost"' >> $testsconfig
	echo "db.username=\"${dbusername}\"" >> $testsconfig
	echo "db.password=\"${dbpassword}\"" >> $testsconfig
	echo "db.dbname=\"omeka_${slug}_test\"" >> $testsconfig
	echo 'paths.imagemagick="/usr/bin"' >> $testsconfig
	echo "paths.tempDir=\"${teststemp}\"" >> $testsconfig
	echo '[site]' >> $testsconfig
	echo 'debug.exceptions=0' >> $testsconfig
	echo 'debug.request=0' >> $testsconfig
	echo 'log.sql=0' >> $testsconfig
	echo 'log.errors=0' >> $testsconfig
	echo 'jobs.dispatcher.default="Omeka_Job_Dispatcher_Adapter_Synchronous"' >> $testsconfig
	echo 'locale=""' >> $testsconfig

	# Set permissions
	chown -R "${wwwuser}:${wwwgroup}" "$targetdir"
	
	# Done configuring Omeka
	>&2 echo "DONE"

	# Clean up
	>&2 echo -n "Cleaning up... "
	rm -f $sqlfile || fail
	>&2 echo "DONE"

	# Instruct user to visit install/install.php
	>&2 echo "Omeka is now installed. Visit /omeka-${slug}/install/install.php to complete setup."
}

# omekarm <slug> <targetdir> <dbusername>
function omekarm {
	# Capture arguments
	slug=$1
	targetdir=$2
	dbusername=$3
	
	# Stop if the target doesn't already exist
	if [ ! -d "$targetdir" ]; then
		>&2 echo "The target directory ${targetdir} does not exist. Please ensure that there is an Omeka installation there."
		fail
	fi

	# Blow up database and database user
	sqlfile=`mktemp`
	echo "DROP DATABASE omeka_${slug};" >> $sqlfile
	echo "DROP DATABASE omeka_${slug}_test;" >> $sqlfile
	echo "DROP USER '"${dbusername}"';" >> $sqlfile
	>&2 echo -n "Clearing MySQL database and user... "
	mysql -u "$rootuser" --password="$rootpass" < $sqlfile || fail
	>&2 echo "DONE"
	
	# Blow up the directory
	>&2 echo -n "Removing installation directory... "
	rm -Rf $targetdir || fail
	rm -Rf "/tmp/omeka_${slug}_test"
	>&2 echo "DONE"

	# Clean up
	>&2 echo -n "Cleaning up... "
	rm -f $sqlfile || fail
	>&2 echo "DONE"
}

# omekaclone <origslug> <origdir> <origusername> <origpassword> <slug> <targetdir> <dbusername> <dbpassword>
function omekaclone {
	# Capture arguments
	origslug=$1
	origdir=$2
	origusername=$3
	origpassword=$4
	slug=$5
	targetdir=$6
	dbusername=$7
	dbpassword=$8
	
	# Stop if the target already exists
	if [ -d "$targetdir" ]; then
		>&2 echo "The target directory ${targetdir} already exists. Please remove this installation before continuing."
		fail
	fi
	
	# Stop if the original doesn't already exist
	if [ ! -d "$origdir" ]; then
		>&2 echo "The source directory ${origdir} does not exist. Please ensure that there is an Omeka installation there."
		fail
	fi
	
	# Create commands for generating database user
	sqlfile=`mktemp`
	echo "CREATE DATABASE omeka_${slug};" >> $sqlfile
	echo "CREATE DATABASE omeka_${slug}_test;" >> $sqlfile
	echo "CREATE USER ${dbusername} IDENTIFIED BY '"${dbpassword}"';" >> $sqlfile
	echo "GRANT ALL ON omeka_${slug}.* TO ${dbusername};" >> $sqlfile
	echo "GRANT ALL ON omeka_${slug}_test.* TO ${dbusername};" >> $sqlfile
	echo "FLUSH PRIVILEGES;" >> $sqlfile
	
	# Run MySQL commands
	>&2 echo -n "Creating new MySQL database and user... "
	mysql -u "$rootuser" --password="$rootpass" < $sqlfile || fail
	>&2 echo "DONE"
	
	# Dump and reimport
	>&2 echo -n "Copying MySQL databases... "
	mysqldump "omeka_${origslug}" -u "$rootuser" --password="$rootpass" | mysql "omeka_${slug}" -u "$rootuser" --password="$rootpass" || fail
	mysqldump "omeka_${origslug}_test" -u "$rootuser" --password="$rootpass" | mysql "omeka_${slug}_test" -u "$rootuser" --password="$rootpass" || fail
	>&2 echo "DONE"
	
	# Copy directories
	>&2 echo -n "Copying Omeka Installation... "
	cp -Rf $origdir $targetdir || fail
	>&2 echo "DONE"
	
	# Start configuring Omeka
	>&2 echo -n "Reconfiguring Omeka... "

	# Fill db.ini
	dbini="${targetdir}/db.ini"
	: > $dbini
	echo '[database]' >> $dbini
	echo 'host="localhost"' >> $dbini
	echo "username=\"${dbusername}\"" >> $dbini
	echo "password=\"${dbpassword}\"" >> $dbini
	echo "dbname=\"omeka_${slug}\"" >> $dbini
	echo 'prefix="omeka_"' >> $dbini
	echo 'charset="utf8"' >> $dbini

	# Fill .htaccess
	rm -f "${targetdir}/.htaccess" || fail
	cp "${targetdir}/.htaccess.changeme" "${targetdir}/.htaccess" || fail
	echo 'SetEnv APPLICATION_ENV development' >> "${targetdir}/.htaccess"

	# Fill config.ini (keep original for now)
	# rm -f "${targetdir}/application/config/config.ini" || fail
	# cp "${targetdir}/application/config/config.ini.changeme" "${targetdir}/application/config/config.ini" || fail

	# Fill tests/config.ini
	testsconfig="${targetdir}/application/tests/config.ini"
	teststemp="/tmp/omeka_${slug}_test"
	mkdir $teststemp
	: > $testsconfig
	echo '[testing]' >> $testsconfig
	echo 'db.host="localhost"' >> $testsconfig
	echo "db.username=\"${dbusername}\"" >> $testsconfig
	echo "db.password=\"${dbpassword}\"" >> $testsconfig
	echo "db.dbname=\"omeka_${slug}_test\"" >> $testsconfig
	echo 'paths.imagemagick="/usr/bin"' >> $testsconfig
	echo "paths.tempDir=\"${teststemp}\"" >> $testsconfig
	echo '[site]' >> $testsconfig
	echo 'debug.exceptions=0' >> $testsconfig
	echo 'debug.request=0' >> $testsconfig
	echo 'log.sql=0' >> $testsconfig
	echo 'log.errors=0' >> $testsconfig
	echo 'jobs.dispatcher.default="Omeka_Job_Dispatcher_Adapter_Synchronous"' >> $testsconfig
	echo 'locale=""' >> $testsconfig
	
	# Done configuring Omeka
	>&2 echo "DONE"

	# Clean up
	>&2 echo -n "Cleaning up... "
	rm -f $sqlfile || fail
	>&2 echo "DONE"
}

# linkloris <slug> <targetdir> <lorisdir>
function linkloris {
	ln -s "$2/files/original" "$3/omeka-$1"
}

# Capture required parameters
if [ -z "$1" ] || [ -z "$2" ]; then
	usagehint
fi
command=$0
verb=$1
case $verb in
	"new")
		slug=$2
		shift
		;;
	"rm")
		slug=$2
		shift
		;;
	"clone")
		if [ -z "$3" ]; then
			usagehint
		fi
		origslug=$2
		slug=$3
		shift
		shift
		;;
	"log")
		slug=$2
		shift
		;;
	"update")
		slug=$2
		shift
		;;
	*)
		usagehint
		;;
esac

# Derived parameter defaults
origdir="${httproot}/omeka-${origslug}"
origuser="omeka${origslug}"
origpass="omeka${origslug}root1108"
targetdir="${httproot}/omeka-${slug}"
dbuser="omeka${slug}"
dbpass="omeka${slug}root1108"
branch="master"
repo="https://github.com/omeka/Omeka.git"
useloris=1

# Capture optional parameters
while [ ! -z "$2" ]
do
	shift
	case $1 in
		"--branch")
			shift
			if [ -z "$1" ]; then
				usagehint
			fi
			branch=$1
			;;
		"--repo")
			shift
			if [ -z "$1" ]; then
				usagehint
			fi
			repo=$1
			;;
		"--no-loris")
			shift
			useloris=0
			;;
	esac
done

# Run the right command
case $verb in
	"new")
		omekanew $slug $targetdir $branch $repo $dbuser $dbpass
		if [ ! -z $useloris ]; then
			linkloris $slug $targetdir $lorisroot
		fi
		;;
	"rm")
		omekarm $slug $targetdir $dbuser
		if [ -L "${lorisroot}/omeka-${slug}" ]; then
			rm -f "${lorisroot}/omeka-${slug}"
		fi
		;;
	"clone")
		omekaclone $origslug $origdir $origuser $origpass $slug $targetdir $dbuser $dbpass
		if [ ! -z $useloris ]; then
			linkloris $slug $targetdir $lorisroot
		fi
		;;
	"log")
		tail -f "$targetdir/application/logs/errors.log"
		;;
	"update")
		pushd "$targetdir" >/dev/null 2>&1
		git pull
		popd >/dev/null 2>&1
		;;
esac
