#!/usr/bin/env bash

set -e

echo Running 'stretch' provisioning...

apt-get update
apt-get install -y net-tools