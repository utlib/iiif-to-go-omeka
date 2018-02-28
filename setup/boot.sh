#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
echo "IIIF in a Box: Initializing setup..."

apt-get update -qqy > /dev/null 2>&1
apt-get -qqy install wget git unzip imagemagick > /dev/null 2>&1
