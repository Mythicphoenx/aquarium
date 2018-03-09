#!/bin/bash
if [ $# -ne 1 ]; then
    echo $0: usage: ./run.sh  password
    exit 0
fi

# Configure IP address in "hosts" file. If you have more than one
# Raspberry Pi, add more lines and enter details
i=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
h=$(hostname)

echo "$i" > ~/.vault_pass.txt

echo "[rpi]" > ~/aquarium/hosts
echo "$i ansible_connection=ssh ansible_ssh_user=pi ansible_ssh_pass="$1 >> ~/aquarium/hosts

nohub ansible-playbook main.yml ~/.vault_pass.txt > /home/pi/aquarium/ansible.log &

rm /home/pi/aquarium/hosts 2>/dev/null
rm /home/pi/aquarium/main.retry 2>/dev/null
rm /home/pi/aquarium/nohup.out 2>/dev/null

