# -*- mode: ruby -*-
# vi: set ft=ruby :

$pubkey = "<MY_PUB_KEY>";
file_to_disk = './var-lib-docker/large_disk.vdi'

Vagrant.configure(2) do |config|

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.box = "debian/jessie64"
  config.vm.network "private_network", ip: "<VM_IP>"

  # Mac OS X
  config.vm.synced_folder "<MY_HOME>", "<MY_HOME>", type: "nfs"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "<VM_RAM>"
     vb.name = "<VM_NAME>"
     vb.customize ['createhd', '--filename', file_to_disk, '--size', 50 * 1024]
     vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]

  end

  # we need a newline after vagrant default key
  config.vm.provision "shell", inline: "echo '' >> .ssh/authorized_keys"
  config.vm.provision "shell", inline: "echo '" + $pubkey + "' >> .ssh/authorized_keys"

  config.vm.provision "shell", inline: "sudo mkfs.ext4 /dev/sdb"
  config.vm.provision "shell", inline: "sudo mkdir -p /var/lib/docker"
  config.vm.provision "shell", inline: "sudo mount -t ext4 /dev/sdb /var/lib/docker"

end
