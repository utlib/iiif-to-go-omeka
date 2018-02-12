#!/bin/bash

DEBIAN_FRONTEND=noninteractive

apt-get update -qqy > /dev/null
apt-get -qqy install wget git unzip imagemagick > /dev/null
