# -*- mode: ruby -*-
# vi: set ft=ruby :

pubkey = ENV['PUBKEY'];

username = ENV['USER']
docker_hdd= './var-lib-docker/docker_hdd.vdi'
home_dir = '/Users/' + username

Vagrant.configure(2) do |config|

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.box = "debian/jessie64"
  config.vm.network "private_network", ip: "192.168.87.70"

  # Mac OS X

  config.vm.synced_folder home_dir, home_dir, type: "nfs"

  # Name in Vagrant
  config.vm.define "vado" do |vado|
  end

  config.vm.provider "virtualbox" do |vb|
     vb.memory = 2048
     # Name in VBoxManage
     vb.name = "vado"
     vb.customize ['createhd', '--filename', docker_hdd, '--size', 50 * 1024]
     vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', docker_hdd]

  end

  # we need a newline after vagrant default key
  config.vm.provision "shell", inline: "echo '' >> .ssh/authorized_keys"
  config.vm.provision "shell", inline: "echo '" + pubkey + "' >> .ssh/authorized_keys"

  config.vm.provision "shell", inline: "mkfs.ext4 /dev/sdb"
  config.vm.provision "shell", inline: "mkdir -p /var/lib/docker"
  config.vm.provision "shell", inline: "mount -t ext4 /dev/sdb /var/lib/docker"

end
