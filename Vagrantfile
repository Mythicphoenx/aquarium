Vagrant.configure(2) do |config|
    config.vm.define "ansible" do |ctl|
        ctl.vm.box = "bento/ubuntu-16.04"
        ctl.vm.hostname = "ansible"
		
#        config.vm.network "public_network", ip: "192.168.1.10"
		config.vm.network :public_network, ip: "192.168.1.10", :netmask => '255.255.255.0', :bridge => 'Intel(R) Dual Band Wireless-AC 3165'
		config.vm.provision "shell",
			run: "always",
			inline: "eval `route -n | awk '{ if ($8 ==\"eth0\" && $2 != \"0.0.0.0\") print \"route del default gw \" $2; }'`"
		# default router
		config.vm.provision "shell",
			run: "always",
			inline: "route add default gw 192.168.1.1"
		ctl.vm.provider "virtualbox" do |vb|
            vb.memory = 2048			
			vb.customize ["modifyvm", :id, "--nicpromisc1", "allow-all"]
			vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
		end
    end
    config.vm.provision :shell , inline: <<-SHELL
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install -y ansible sshpass python-jmespath
sudo apt-get install git -y
sudo apt-get install arp-scan -y
sudo apt-get install nmap -y


su -c "git clone https://github.com/Revenberg/aquarium.git" vagrant
su -c "touch ~/.vault_pass.txt" vagrant

sudo arp-scan --interface=eth1 --localnet -r 15
sudo nmap -T5 -n -p 22 --open --min-parallelism 200 192.168.1.0/24
su -c "echo "[rpi]" > ~/hosts" vagrant
arp-scan --interface=eth1 --localnet -r 25  > /home/vagrant/hosts.lst

rpi_ip=$(sudo grep b8:27:eb /home/vagrant/hosts.lst | head -n1 | cut -db -f1)
echo "$rpi_ip ansible_connection=ssh ansible_ssh_user=pi ansible_ssh_pass=PASSWRD" >> /home/vagrant/hosts
sudo rm /home/vagrant/hosts.lst
    SHELL
 end
