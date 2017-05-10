#!/usr/bin/env bash

# ---------------------------------------------
# script to run once on initial setup
# ---------------------------------------------
set -e

echo Running 'initial' provisioning...
# install VBoxGuestAdditions for eg. timesync
echo 'deb http://ftp.de.debian.org/debian jessie main contrib non-free' > /etc/apt/sources.list.d/debian_contrib_nonfree.list
apt-get update
apt-get install -y virtualbox-guest-additions-iso
mount /usr/share/virtualbox/VBoxGuestAdditions.iso /mnt/
# workaround for misleading return code != 0
# see http://stackoverflow.com/a/25943638
export REMOVE_INSTALLATION_DIR=0
/mnt/VBoxLinuxAdditions.run --nox11
umount /mnt/
# set hold flag for package to disable auto (dist)upgrades
apt-mark hold virtualbox-guest-additions-iso
systemctl disable ntpd 2>/dev/null
systemctl enable vboxadd-service
service vboxadd-service restart

echo 'Done: initial setup'
