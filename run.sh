#!/bin/bash
if [ $# -ne 1 ]; then
    echo $0: usage: ./install.sh  password
    exit 0
fi

# Configure IP address in "hosts" file. If you have more than one
# Raspberry Pi, add more lines and enter details
i=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
h=$(hostname)

echo "$i  ansible_connection=ssh ansible_ssh_user=pi ansible_ssh_pass="$1 >> ~/aquarium/hosts

ansible-playbook main.yml

