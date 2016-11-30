# -*- mode: ruby -*-
# vi: set ft=ruby :

$pubkey = "ssh-rsa <ADD_YOUR_PUBKEY_HERE>";

Vagrant.configure(2) do |config|

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.box = "debian/jessie64"
  config.vm.network "private_network", ip: "192.168.33.10"

  # Mac OS X
  config.vm.synced_folder "/Users/<ADD_YOUR_USERNAME>", "/Users/<ADD_YOUR_USERNAME>", type: "nfs"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "2048"
  end

  config.vm.provision "shell", inline: "echo '" + $pubkey + "' >> .ssh/authorized_keys"

end
