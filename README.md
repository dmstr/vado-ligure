# Vado Ligure

## Usage

### Create SSH key

    ssh-keygen -N '' -t rsa -b 4096 -C vado -f id_rsa-vado

### Create template

    boilr template use vado dev-1

## Development

    boilr template save -f . vado
pubkey

    export PUBKEY="$(cat ssh/d_rsa-vado.pub)"

create VM

    vagrant up
    
create Docker host
    
    docker-machine create \
        -d generic \
        --generic-ssh-user vagrant \
        --generic-ssh-key ssh/id_rsa-vado \
        --generic-ip-address 192.168.87.70 \
        vado

## Create VM as docker-machine

```
# ------------------------------------
# define your VM-Values
# ------------------------------------
VM_NAME=app-vm
VM_IP=192.168.33.10
VM_RAM=4096

# ------------------------------------
# no more changes should be necessary
# -> copy paste
#    Enter password when asked
# ------------------------------------

# create dir for VM-Files
mkdir -p $VM_NAME && cd $VM_NAME

# create SSH key
mkdir -p ssh
chmod 700 ssh
ssh-keygen -N '' -t rsa -b 4096 -C "docker-machine@$VM_NAME" -f ssh/id_rsa-$VM_NAME
MY_PUB_KEY=$(cat ssh/id_rsa-app-vm.pub)

# get vado repo
git clone git@git.hrzg.de:dmstr/vado-ligure.git

# create VAGRANT file from template
cp vado-ligure/Vagrantfile Vagrantfile
sed -i .dist -e "s#<MY_PUB_KEY>#$MY_PUB_KEY#g" \
             -e "s#<MY_HOME>#$HOME#g" \
             -e "s#<VM_NAME>#$VM_NAME#g" \
             -e "s#<VM_IP>#$VM_IP#g" \
             -e "s#<VM_RAM>#$VM_RAM#g" Vagrantfile

# VM starten
vagrant up

# provision VM with docker-machine
docker-machine create \
    -d generic \
    --generic-ssh-user vagrant \
    --generic-ssh-key ssh/id_rsa-$VM_NAME \
    --generic-ip-address $VM_IP \
    $VM_NAME

# set ENV to new machine
eval $(docker-machine env $VM_NAME)
```
