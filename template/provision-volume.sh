#!/usr/bin/env bash

set -e

echo Running 'always disk' provisioning...

# define device name for disk to check
DISK_DEV_NAME=/dev/sdb
DISK_M_POINT=/var/lib/docker
DOCKER_RUNS=0

echo "check if $DISK_M_POINT mount is configured, otherwise setup disk and mount options"

if mount | grep -qsE "${DISK_M_POINT}[[:space:]]+type[[:space:]]ext4"; then
  echo "Mount for ${DISK_M_POINT} exists"
else
    echo "Init Mounting /var/lib/docker to secondary disk ${DISK_DEV_NAME}"
    echo "check if ${DISK_DEV_NAME} has ext4 fs"
    if file -Ls ${DISK_DEV_NAME} | grep -q ext4; then
        echo 'No mkfs.ext4 needed';
    else
        mkfs.ext4 ${DISK_DEV_NAME};
    fi

    # get UUID for /dev/sdb to check and/or set /etc/fstab entry
    SDB_UUID=`blkid ${DISK_DEV_NAME} | awk '{print$2}' | sed -e 's/"//g'`

    echo "check /etc/fstab entry for $SDB_UUID on ${DISK_M_POINT}"
    if grep -q $SDB_UUID /etc/fstab; then
        echo "/etc/fstab entry exists"
    else
        echo "adding /etc/fstab entry ${SDB_UUID} to ${DISK_M_POINT}"
        echo '# added from vagrant provision script' >> /etc/fstab
        echo "${SDB_UUID}  ${DISK_M_POINT}  ext4    errors=remount-ro 0  1" >> /etc/fstab
    fi

    # check if docker engine is running, if yes we must stop it before we mount /var/lib/docker
    if service docker status > /dev/null 2>&1; then
        echo 'docker daemon is running, stop it before mount...'
        service docker stop
        DOCKER_RUNS=1
    fi

    echo "mounting ${DISK_M_POINT}"
    mkdir -p ${DISK_M_POINT}
    mount ${DISK_M_POINT}

    # (re)start docker needed?
    if [ $DOCKER_RUNS -eq 1 ]; then
        echo "(re)start docker daemon"
        service docker start
    fi

fi

echo "Done: 'always disk' provisioning"

