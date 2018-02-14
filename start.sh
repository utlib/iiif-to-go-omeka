#!/bin/bash
url="http://127.0.0.1:8080"
vagrant up || exit 127
if [ ! -z `which xdg-open` ]; then
	xdg-open "$url"
elif [ ! -z `which open` ]; then
	open "$url"
fi
