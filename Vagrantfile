# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.define "ansible" do |ctl|
        ctl.vm.box = "bento/ubuntu-16.04"
        ctl.vm.hostname = "ansible"
        config.vm.network "public_network", ip: "192.168.1.10"
		# default router
		config.vm.provision "shell",
			run: "always",
			inline: "route add default gw 192.168.1.1"
		# delete default gw on eth0
		config.vm.provision "shell",
			run: "always",
			inline: "eval `route -n | awk '{ if ($8 ==\"eth0\" && $2 != \"0.0.0.0\") print \"route del default gw \" $2; }'`"
        ctl.vm.provider "virtualbox" do |vb|
            vb.memory = 2048
        end
    end
    config.vm.provision :shell , inline: <<-SHELL
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install -y ansible sshpass python-jmespath
sudo apt-get install git -y

sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X

su -c "git clone https://github.com/Revenberg/aquarium.git" vagrant

    SHELL
 end
