#!/usr/bin/env bash

ssh-keygen -N '' -t rsa -b 4096 -C vado -f {{ VADO_SSH_KEY_FILE }}

vagrant up

docker-machine create \
    -d generic \
    --generic-ssh-user vagrant \
    --generic-ssh-key {{ VADO_SSH_KEY_FILE }} \
    --generic-ip-address {{ VADO_IP }} \
    --engine-storage-driver={{ VADO_STORAGE_DRIVER }} \
{{if VADO_REGISTRY_MIRROR}}    --engine-registry-mirror={{ VADO_REGISTRY_MIRROR }} {{end}}\
    {{ VADO_NAME }}
