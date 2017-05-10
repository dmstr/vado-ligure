#!/usr/bin/env bash

# ---------------------------------------------
# script to run on every (re)start
# ---------------------------------------------
set -e

echo Running 'always' provisioning...

if file -Ls /dev/sdb | grep -q ext4; then
  echo 'No mkfs.ext4 needed';
else
  mkfs.ext4 /dev/sdb;
fi

if mount | grep -qs "/var/lib/docker"; then
  echo 'Mount exists'
else
  echo 'Mounting /var/lib/docker to secondary disk'
  mkdir -p /var/lib/docker
  mount -t ext4 /dev/sdb /var/lib/docker
fi

if service docker status > /dev/null 2>&1; then
  echo 'Restarting docker daemon...'
  service docker restart
fi


echo 'Done: always setup'
