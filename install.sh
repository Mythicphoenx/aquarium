#!/bin/bash
if [ $# -ne 1 ]; then
    echo $0: usage: ./install.sh  password
    exit 0
fi

date >> /home/pi/ansible.log
sudo apt-get update
sudo apt-get autoremove

sudo apt-get install git -y

# Install Ansible and Git on the machine.
sudo apt-get install python-pip git python-dev sshpass -y
sudo pip install ansible
sudo pip install markupsafe

git clone https://github.com/Revenberg/aquarium.git

cd aquarium
./run.sh





