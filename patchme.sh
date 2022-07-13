#!/usr/bin/env bash

apt-get update
sync-available
apt-show-versions -u
uname -r
cat /etc/debian_version
apt-get dist-upgrade --purge
check what's getting updated and what's getting removed!
dpkg -l | grep linux-image
rm_image= echo "What image do you want to remove?"
read rm_image
echo $rm_image
apt-get remove --purge $rm_image
reboot
uname -r
cat /etc/debian_version

