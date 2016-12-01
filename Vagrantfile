# -*- mode: ruby -*-
# vi: set ft=ruby :

$pubkey = "<MY_PUB_KEY>";
file_to_disk = './var-lib-docker/large_disk.vdi'

$script_always = <<SCRIPT
set -e
echo Running 'always' provisioning...
if sudo file -Ls /dev/sdb | grep -q ext4; then
  echo 'no mkfs.ext4 needed';
else
  sudo mkfs.ext4 /dev/sdb;
fi
sudo mkdir -p /var/lib/docker
sudo mount -t ext4 /dev/sdb /var/lib/docker
echo 'Done.'
SCRIPT

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

     unless File.exist?(file_to_disk)
        vb.customize ['createhd', '--filename', file_to_disk, '--size', 50 * 1024]
     end
     vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]

  end

  # we need a newline after vagrant default key
  config.vm.provision "shell", inline: "echo '' >> .ssh/authorized_keys"
  config.vm.provision "shell", inline: "echo '" + $pubkey + "' >> .ssh/authorized_keys"

  config.vm.provision "shell", run: "always", inline: $script_always

end
