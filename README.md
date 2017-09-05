# Vado Ligure

Vagrant Docker - Light Generic User Environment

A Vagrantfile for creating a development Docker host with CLI-based templating support.

---

## Usage ([boilr](https://github.com/tmrts/boilr))

[Download](https://github.com/tmrts/boilr/releases) `boilr` and install to `/home/bin` or `/usr/local/bin`.

### Download template

    boilr template download dmstr/vado-ligure vado

If you need to update an existing template, use

    boilr template download -f dmstr/vado-ligure vado

### Create template

    boilr template use vado dev-1

Go to `dev-1` and initialize the virtual machine

    cd dev-1
    sh init.sh

> Note! If you have NFS as the shared folder type, you may have to enter your password 

Setup environment

    eval $(docker-machine env dev-1)

### Create bash alias

For fast access, you can create an alias in your profile, like

    alias vadovm='VAGRANT_CWD=<PATH-TO>/dev-1 vagrant'

## Development

After changing the template, save a dev version

    boilr template save -f . vadodev

Check all your Vagrant VMs

    vagrant global-status
    
