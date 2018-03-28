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
	echo "Usage: omekash (new|rm|clone <origslug>|log|update|plug|unplug <plugin>|theme|untheme <theme>|archive <zipname>|restore <zipname>) <slug> [--branch <branch>] [--repo <repository>] [--url <url>] [--no-loris]"
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
	git clone -q --branch "$branch" --recursive "$repo" "$targetdir" || fail
	>&2 echo "Omeka downloaded."
	
	# Add IIIF Toolkit
	>&2 echo "Downloading IIIF Toolkit for Omeka..."
	tmpdir=`mktemp -d`
	git clone -q https://github.com/utlib/IiifItems.git --branch v1.1.0 --recursive "$tmpdir/IiifItems" 
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
	echo "UPDATE omeka_options SET value = 'http://127.0.0.1:8181/loris/omeka-${slug}/{FULLNAME}' WHERE name = 'iiifitems_bridge_prefix';" | mysql "omeka_${slug}" -u "$rootuser" --password="$rootpass" || fail
    echo "UPDATE omeka_options SET value = 'http://127.0.0.1:8080/omeka-${slug}/plugins/IiifItems/views/shared/js/mirador' WHERE name = 'iiifitems_mirador_path';" | mysql "omeka_${slug}" -u "$rootuser" --password="$rootpass" || fail
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

# omekaarchive <slug> <targetdir> <filename>
function omekaarchive {
	# Capture arguments
	slug=$1
	targetdir=$2
	filename=$3
	if [[ "${filename:0:1}" != "/" ]]; then
		filename="`pwd`/$filename"
	fi

	# Stop if the target does not exist
	if [ ! -d "$targetdir" ]; then
		>&2 echo "The target directory ${targetdir} does not exist."
		fail
	fi

	# Make temporary directory
	tempdir=`mktemp -d`
	mkdir "${tempdir}/omekapickle" || fail

	# Copy installation
	>&2 echo -n "Copying Omeka installation... "
	ln -s "$targetdir" "${tempdir}/omekapickle/omeka" || fail
	>&2 echo "DONE"

	# Dump SQL
	>&2 echo -n "Dumping SQL... "
	mysqldump "omeka_${slug}" -u "$rootuser" --password="$rootpass" > "${tempdir}/omekapickle/main.sql" || fail
	mysqldump "omeka_${slug}_test" -u "$rootuser" --password="$rootpass" > "${tempdir}/omekapickle/test.sql" || fail
	>&2 echo "DONE"

	# Create zip at filename
	>&2 echo -n "Creating archive... "
	pushd "${tempdir}/omekapickle" > /dev/null
	zip -r9q "$filename" . || { popd; fail; }
	popd > /dev/null
	>&2 echo "DONE"

	# Remove temporary
	>&2 echo -n "Cleaning up... "
	rm -Rf "$tempdir"

	# Done archiving
	>&2 echo "DONE"
}

# omekarestore <slug> <targetdir> <filename> <dbusername> <dbpassword>
function omekarestore {
	# Capture arguments
	slug=$1
	targetdir=$2
	filename=$3
	dbusername=$4
	dbpassword=$5

	# Stop if the target already exists
	if [ -d "$targetdir" ]; then
		>&2 echo "The target directory ${targetdir} already exists."
		fail
	fi

	# Make temporary directory
	tempdir=`mktemp -d`

	# Unzip contents
	>&2 echo -n "Unzipping... "
	extractto "$filename" "$tempdir" || fail
	>&2 echo "DONE"

	# Generate new user
	>&2 echo -n "Creating new MySQL database and user... "
	sqlfile=`mktemp`
	echo "CREATE DATABASE omeka_${slug};" >> $sqlfile
	echo "CREATE DATABASE omeka_${slug}_test;" >> $sqlfile
	echo "CREATE USER ${dbusername} IDENTIFIED BY '"${dbpassword}"';" >> $sqlfile
	echo "GRANT ALL ON omeka_${slug}.* TO ${dbusername};" >> $sqlfile
	echo "GRANT ALL ON omeka_${slug}_test.* TO ${dbusername};" >> $sqlfile
	echo "FLUSH PRIVILEGES;" >> $sqlfile
	mysql -u "$rootuser" --password="$rootpass" < $sqlfile || fail
	rm -f "$sqlfile"
	>&2 echo "DONE"

	# Import the SQL files
	>&2 echo -n "Importing databases... "
	mysql "omeka_${slug}" -u "$dbusername" --password="$dbpassword" < "${tempdir}/main.sql" || fail
	mysql "omeka_${slug}_test" -u "$dbusername" --password="$dbpassword" < "${tempdir}/test.sql" || fail
	echo "UPDATE omeka_options SET value = 'http://127.0.0.1:8181/loris/omeka-${slug}/{FULLNAME}' WHERE name = 'iiifitems_bridge_prefix';" | mysql "omeka_${slug}" -u "$dbusername" --password="$dbpassword" || fail
    echo "UPDATE omeka_options SET value = 'http://127.0.0.1:8080/omeka-${slug}/plugins/IiifItems/views/shared/js/mirador' WHERE name = 'iiifitems_mirador_path';" | mysql "omeka_${slug}" -u "$dbusername" --password="$dbpassword" || fail
	>&2 echo "DONE"

	# Move the extracted Omeka instance
	>&2 echo -n "Moving Omeka into position... "
	mv -f "${tempdir}/omeka" "$targetdir" || fail
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
	cp -p "${targetdir}/.htaccess.changeme" "${targetdir}/.htaccess" || fail
	echo 'SetEnv APPLICATION_ENV development' >> "${targetdir}/.htaccess"

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
	
	# Remove temporary
	>&2 echo -n "Cleaning up... "
	rm -Rf "$tempdir"

	# Done restoring
	>&2 echo "DONE"
}

# linkloris <slug> <targetdir> <lorisdir>
function linkloris {
	ln -s "$2/files/original" "$3/omeka-$1"
}

# extractto <source> <target>
function extractto {
	# Capture arguments
	source="$1"
	target="$2"
	# If from an online source, download to temporary file
	if [[ "$source" == http://* ]] || [[ "$source" == https://* ]]; then
		fname=`mktemp`
		rm -f "$fname"
		fromlocal=0
		wget -q -O "$fname" "$source"
	# Otherwise, reference the local file directly
	else
		fname="$source"
		fromlocal=1
	fi
	# Extract form the local file
	extension="${source##*.}"
	case "$extension" in
		"zip")
			unzip -qq "$fname" -d "$target" || failed=1
			;;
		"tgz")
			tar -xzf "$fname" -C "$target" || failed=1
			;;
		"tar")
			tar -xf "$fname" -C "$target" || failed=1
			;;
		*)
			echo "Unsupported extension \"$extension\". Expected zip, tgz or tar."
			failed=1
			;;
	esac
	# If from an online source, delete the temporary file
	if [ -z $fromlocal ]; then
		rm -f "$fname"
	fi
	# Exit if error
	if [ ! -z "$failed" ]; then
		exit 2
	fi
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
	"plug")
		slug=$2
		shift
		;;
	"unplug")
		if [ -z "$3" ]; then
			usagehint
		fi
		slug=$3
		plugslug=$2
		shift
		shift
		;;
	"theme")
		slug=$2
		shift
		;;
	"untheme")
		if [ -z "$3" ]; then
			usagehint
		fi
		slug=$3
		themeslug=$2
		shift
		shift
		;;
	"archive")
		if [ -z "$3" ]; then
			usagehint
		fi
		slug=$3
		zipname=$2
		shift
		shift
		;;
	"restore")
		if [ -z "$3" ]; then
			usagehint
		fi
		slug=$3
		zipname=$2
		shift
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
url=""
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
		"--url")
			shift
			if [ -z "$1" ]; then
				usagehint
			fi
			url=$1
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
		git pull -q
		popd >/dev/null 2>&1
		;;
	"plug")
		if [ ! -z "$url" ]; then
			extractto "$url" "$targetdir/plugins"
		elif [ ! -z "$repo" ]; then
			pushd "$targetdir/plugins" > /dev/null
			git clone -q "$repo" --branch "$branch" --recursive
			popd > /dev/null
		else
			echo "You must specify a plugin download URL in a --url parameter, or a repository in a --repo parameter."
			exit 2
			failed=1
		fi
		;;
	"unplug")
		rm -Rf "$targetdir/plugins/$plugslug"
		;;
	"theme")
		if [ ! -z "$url" ]; then
			extractto "$url" "$targetdir/themes"
		elif [ ! -z "$repo" ]; then
			pushd "$targetdir/plugins" > /dev/null
			git clone -q "$repo" --branch "$branch" --recursive
			popd > /dev/null
		else
			echo "You must specify a theme download URL in a --url parameter, or a repository in a --repo parameter."
			failed=1
		fi
		if [ ! -z "$failed" ]; then
			exit 2
		fi
		;;
	"untheme")
		rm -Rf "$targetdir/themes/$themeslug"
		;;
	"archive")
		omekaarchive "$slug" "$targetdir" "$zipname"
		;;
	"restore")
		omekarestore "$slug" "$targetdir" "$zipname" "$dbuser" "$dbpass"
		if [ ! -z $useloris ]; then
			linkloris $slug $targetdir $lorisroot
		fi
		;;
esac
