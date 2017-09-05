#!/usr/bin/env bash

set -e

echo "Running 'zfs init' provisioning..."

# define device name for disk to check
DISK_DEV_NAME=/dev/sdb
M_POINT=/var/lib/docker
DOCKER_RUNS=0

export DEBIAN_FRONTEND=noninteractive
echo 'deb http://deb.debian.org/debian stretch contrib' > /etc/apt/sources.list.d/debian_stretch_contrib.list
echo 'deb-src http://deb.debian.org/debian stretch contrib' >> /etc/apt/sources.list.d/debian_stretch_contrib.list
apt-get update

apt install -y linux-headers-$(uname -r)
echo "compile and install zfs-dkms, this can take a while, be patient...."
apt-get install -y zfs-dkms

/sbin/modprobe zfs
zpool create -f zpool-docker -m $M_POINT $DISK_DEV_NAME

echo "Done: 'zfs init' provisioning"
