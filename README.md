# Vado Ligure

Create SSH key

Start VM

    vagrant up

Setup Docker host

    docker-machine create \
        -d generic \
        --generic-ssh-user vagrant \
        --generic-ssh-key ssh/id_rsa-vado_ligure \
        --generic-ip-address 192.168.33.10 \
        v1
