#!/bin/bash
if [ $# -ne 1 ]; then
    echo $0: usage: ./install.sh  password
    exit 0
fi

date >> /home/pi/ansible.log
sudo apt-get update -y
sudo apt-get autoremove -y

sudo apt-get install git -y

# Install Ansible and Git on the machine.
sudo apt-get install python3-pip python3-dev sshpass -y
sudo pip3 install ansible
sudo pip3 install markupsafe

git clone https://github.com/Revenberg/aquarium.git

cd aquarium
./run.sh $1





