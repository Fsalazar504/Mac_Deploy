#!/usr/local/env bash

read -p "Run this script to update this linux system"
echo "Run this script to update this linux system:"
apt-get update
sync-available
apt-show-versions -u
uname -r
cat /etc/debian_version
apt-get dist-upgrade --purge
check what's getting updated and what's getting removed!
dpkg -l | grep linux-image
apt-get remove --purge <old linux-images -1>
reboot
uname -r
cat /etc/debian_version
