#!/usr/bin/env bash

# ---------------------------------------------
# script to run once on initial setup
# ---------------------------------------------
set -e

echo Running 'initial VBoxGuestAdditions' provisioning...
# install VBoxGuestAdditions for eg. timesync
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y upgrade
apt-get install -y build-essential module-assistant
m-a -i prepare

wget -q http://download.virtualbox.org/virtualbox/5.1.26/VBoxGuestAdditions_5.1.26.iso

mkdir -p /mnt/vbox-cd
mount -o loop /home/vagrant/VBoxGuestAdditions_5.1.26.iso /mnt/vbox-cd
export REMOVE_INSTALLATION_DIR=0
export TERM=xterm
sh /mnt/vbox-cd/VBoxLinuxAdditions.run --nox11 || echo "VBoxLinuxAdditions return $?"
modprobe vboxguest || echo "modprobe return $?"
systemctl status openntpd > /dev/null 2>&1 && systemctl disable openntpd 2>/dev/null || echo "openntpd not found, nothing to disable"
modprobe vboxguest
systemctl enable vboxadd-service
systemctl start  vboxadd-service
umount /mnt/vbox-cd && rmdir /mnt/vbox-cd
rm /home/vagrant/VBoxGuestAdditions_5.1.26.iso

systemctl status vboxadd-service

echo 'Done: initial VBoxGuestAdditions setup'
