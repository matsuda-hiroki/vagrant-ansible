# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

# Commented out because it does not work with the default settings in the cmd.exe
#  Encoding.default_external = 'UTF-8'

  config.ssh.insert_key = false
  config.vm.box = "bento/centos-6.7"

  config.vm.provider :virtualbox do |vb|
    vb.cpus = 2
    vb.memory = "4096"
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
    vb.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", 0]
  end

  config.vm.define "lamp" do |lamp|
    lamp.vm.hostname = "laravel"
    lamp.vm.network :private_network, ip: "192.168.33.11", netmask: "255.255.255.0"
  end

  config.vm.provision :shell, :path => "provision.sh"
end
